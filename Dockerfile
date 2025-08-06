FROM ruby:3.4.5-bookworm

# Install Node.js 22.x (Latest LTS)
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash -

# Instala dependencias del sistema necesarias para build y test
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs netcat-openbsd postgresql-client --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Install pnpm
RUN npm install -g pnpm

RUN gem update --system 3.7.1 && gem install rails -v 8.0.2 && \
    bundle config set --local path '.bundle_cache/'

WORKDIR /app

# Copy package files first for better Docker layer caching
COPY package.json ./
RUN npm install

# Copy application code
COPY . .

# Build assets with Vite
RUN npm run build

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["entrypoint.sh"]

# El comando por defecto para iniciar el servidor de Rails
CMD ["rails", "server", "-b", "0.0.0.0"]
