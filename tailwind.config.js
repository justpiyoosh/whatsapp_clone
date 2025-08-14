/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/views/**/*.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/components/**/*.{erb,rb}',
    './config/initializers/simple_form.rb',
    './lib/tasks/**/*.rake',
    './lib/generators/**/*',
    './lib/**/*.rb',
    './node_modules/flowbite/**/*.js'
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}

