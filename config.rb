require 'slim'
###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout
page '/index.html', layout: :layout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# We need to disable HAML warnings, since templating engine for HAML are setting some
# settings, which are no longer available in HAML. More info here:
# https://github.com/middleman/middleman/issues/2087
Haml::TempleEngine.disable_option_validator!

# General configuration
set :haml, { format: :html5 }
set :markdown_engine, :kramdown
set :markdown, auto_ids: false

activate :google_analytics do |ga|
  ga.tracking_id = 'UA-xxx-xxx-xx'
end

activate :directory_indexes
activate :autoprefixer
activate :sprockets
ignore 'javascripts/main.js'

activate :external_pipeline,
  name: :webpack,
  command: "./node_modules/webpack/bin/webpack.js --mode #{build? ? 'production --bail' : 'development --watch -d'}",
  source: '.tmp/dist',
  latency: 1

activate :minify_css

# Reload the browser automatically whenever files change
configure :development do
  config[:host] = 'http://localhost:4567'
  activate :livereload
  activate :pry
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
helpers do
  def news_paragraphs
    Dir['source/news/*.html.md']
      .map { |file| File.basename(file, '.html.md') }
      .sort.reverse
      .map { |file| [file, Date.parse(file)]}
  end
end

# Build-specific configuration
configure :build do
  config[:host] = '/'
  activate :favicon_maker do |f|
    f.template_dir = 'source/images/'
    f.icons = {
      'icon.png' => [
        { icon: 'apple-touch-icon-precomposed.png', size: '152x152' },
        { icon: 'favicon.png', size: '152x152' },
        { icon: 'favicon.ico', size: '64x64,32x32,24x24,16x16' }
      ]
    }
  end
  ignore 'templates/*'
  ignore 'javascripts/main.js'
  activate :relative_assets
  set :relative_links, true
end
