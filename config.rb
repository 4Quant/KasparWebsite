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
set :markdown_engine, :kramdown
set :markdown, auto_ids: false

activate :google_analytics do |ga|
  ga.tracking_id = 'UA-xxx-xxx-xx'
end

activate :directory_indexes
activate :autoprefixer

activate :imageoptim do |options|
  # Use a build manifest to prevent re-compressing images between builds
  options.manifest = true

  # Silence problematic image_optim workers
  options.skip_missing_workers = true

  # Cause image_optim to be in shouty-mode
  options.verbose = true

  # Setting these to true or nil will let options determine them (recommended)
  options.nice = true
  options.threads = true

  # Image extensions to attempt to compress
  options.image_extensions = ['.png', '.jpg', '.jpeg', '.gif', '.svg']

  # Compressor worker options, individual optimisers can be disabled by passing
  # false instead of a hash
  options.advpng    = { level: 4 }
  options.gifsicle  = { interlace: false }
  options.jpegoptim = { strip: ['all'], max_quality: 90 }
  options.jpegtran  = { copy_chunks: false, progressive: true, jpegrescan: true }
  options.optipng   = { level: 6, interlace: false }
  options.pngcrush  = { chunks: ['alla'], fix: false, brute: false }
  options.pngout    = { copy_chunks: false, strategy: 0 }
  options.svgo      = {}
end

activate :sprockets
sprockets.append_path "#{root}/node_modules/@ibm"
sprockets.append_path "#{root}/node_modules"
ignore 'javascripts/main.js'

activate :external_pipeline,
  name: :webpack,
  command: "./node_modules/webpack/bin/webpack.js --mode #{build? ? 'production --bail' : 'development --watch -d'}",
  source: '.tmp/dist',
  latency: 1


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
  ignore 'javascripts/main.bundle.js'
  activate :minify_css
  activate :minify_javascript
  activate :relative_assets
  activate :gzip
  set :relative_links, true
end

# copy webpack built js file into build dir
after_build do
  system 'cp .tmp/dist/javascripts/main.bundle.js build/javascripts/'
  system 'gzip -c .tmp/dist/javascripts/main.bundle.js > build/javascripts/main.bundle.js.gz'
end
