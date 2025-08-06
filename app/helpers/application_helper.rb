module ApplicationHelper
  # Fallback helpers if ViteRuby helpers are not available
  def vite_client_tag
    return unless Rails.env.development?
    javascript_include_tag "http://localhost:3036/vite/client", type: "module"
  end

  def vite_javascript_tag(name)
    if Rails.env.development?
      javascript_include_tag "http://localhost:3036/#{name}.js", type: "module", defer: true
    else
      # Production: use compiled assets
      manifest = vite_manifest
      if manifest && manifest["entrypoints/#{name}.js"]
        javascript_include_tag "/vite/assets/#{manifest["entrypoints/#{name}.js"]["file"]}", defer: true
      end
    end
  end

  def vite_stylesheet_tag(name)
    return if Rails.env.development? # CSS is injected by Vite in dev mode
    
    # Production: use compiled assets
    manifest = vite_manifest
    if manifest && manifest["entrypoints/#{name}.js"] && manifest["entrypoints/#{name}.js"]["css"]
      css_file = manifest["entrypoints/#{name}.js"]["css"].first
      stylesheet_link_tag "/vite/assets/#{css_file}"
    end
  end

  private

  def vite_manifest
    @vite_manifest ||= begin
      manifest_path = Rails.root.join("public/vite/.vite/manifest.json")
      if File.exist?(manifest_path)
        JSON.parse(File.read(manifest_path))
      else
        {}
      end
    end
  end
end
