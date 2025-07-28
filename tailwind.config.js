/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js"
  ],
  theme: {
    extend: {},
  },
  plugins: [
    require("daisyui")
  ],
  daisyui: {
    themes: true, // Enable all themes
    darkTheme: "dark", // Default dark theme
    base: true, // Apply background color and foreground color for root element
    styled: true, // Include daisyUI colors and design decisions
    utils: true, // Add responsive and modifier utility classes
    prefix: "", // Prefix for daisyUI classnames (components, modifiers and responsive class names. Not colors)
    logs: true, // Show info about daisyUI version and used config in the console when building CSS
  },
}
