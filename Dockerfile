# syntax=docker/dockerfile:1
# check=error=true

# Este Dockerfile está diseñado para producción.
# Asegúrate de que RUBY_VERSION coincida con la versión en tu .ruby-version
ARG RUBY_VERSION=3.4.5
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# Directorio de la aplicación Rails
WORKDIR /rails

# Instalar paquetes base necesarios en la imagen final
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips libpq5 && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Configurar entorno de producción
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"

# ---------------------------------------------------------------------

# Etapa de construcción (build) para reducir el tamaño de la imagen final
FROM base AS build

# Instalar dependencias del sistema y configurar Node.js v22
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libyaml-dev pkg-config libpq-dev curl && \
    # Configurar el repositorio de NodeSource para la v22 y luego instalarlo
    curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install --no-install-recommends -y nodejs && \
    # Limpiar caché de apt
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copiar archivos de dependencias de JS e instalar los módulos (Tailwind, DaisyUI, etc.)
COPY package.json package-lock.json* ./
# Usamos --no-optional para una instalación más limpia en CI/CD y removemos el caché después
RUN npm install --no-optional && npm cache clean --force

# Copiar archivos de gemas e instalarlas
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Copiar el código de la aplicación
COPY . .

# Precompilar bootsnap para un arranque más rápido
RUN bundle exec bootsnap precompile app/ lib/

# Precompilar assets para producción
# Se usa una clave dummy para no necesitar la RAILS_MASTER_KEY en esta etapa
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

FROM base

COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Crear y usar un usuario no-root por seguridad
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    mkdir -p coverage && \
    chown -R rails:rails db log storage tmp coverage spec

# Dar permisos de escritura al usuario rails en el directorio de bundler
# Esto permite ejecutar bundle install dentro del contenedor
RUN chown -R rails:rails "${BUNDLE_PATH}" && \
    chmod -R u+w "${BUNDLE_PATH}"

USER 1000:1000

ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Exponer el puerto y arrancar el servidor (usando la sintaxis exec para que las señales se manejen correctamente)
EXPOSE 3000
CMD ["./bin/rails", "server"]