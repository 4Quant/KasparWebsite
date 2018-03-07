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

activate :autoprefixer
activate :sprockets
activate :asset_hash

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
  def md_article(md_partial, slug = nil)
    partial 'partials/article', locals: { markdown_file: "articles/_#{md_partial}.md",
                                          slug: slug&.parameterize }
  end
end

# Build-specific configuration
configure :build do
  config[:host] = 'https://4quant.com'
  activate :favicon_maker do |f|
    f.template_dir = 'source/images/'
    f.icons = {
      'icon.png' => [
        { icon: 'apple-touch-icon-precomposed.png', size: '152x152' },
        { icon: 'favicon.png', size: '152x152' },
        { icon: 'favicon.ico', size: '64x64,32x32,24x24,16x16' },
        { icon: 'mstile-70x70.png', size: '70x70' },
        { icon: 'mstile-144x144.png', size: '144x144' },
        { icon: 'mstile-150x150.png', size: '150x150' },
        { icon: 'mstile-310x310.png', size: '310x310' },
        { icon: 'mstile-310x150.png', size: '310x150' }
      ]
    }
  end

  activate :relative_assets
  set :relative_links, true
end
