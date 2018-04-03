require 'slim'
require 'youtube_id'
require 'lib/picture_tag'
require 'lib/responsive_embed'

# Global configs via CONSTANTS
#

HOST_CONFIG = { development: 'http://localhost:4567', production: 'https://4quant.gitlab.io' }.freeze

# Extensions that dont need any options
ENABLE_EXTENSIONS_NO_OPTS = {
  development: [:directory_indexes, :autoprefixer, :sprockets, :pry],
  production: [:directory_indexes, :autoprefixer, :sprockets, :minify_css, :minify_javascript, :gzip]
}.freeze

WEBPACK_COMMAND = { production: 'production --bail', development: 'development --watch -d' }.freeze
WEBPACK_OPTIONS = {
  name: :webpack, source: '.tmp/dist', latency: 1,
  command: build? ? 'yarn run wp-build' : 'yarn run wp-dev'
}.freeze

SPROCKETS_IMPORT_PATHS = ['node_modules', '.tmp/dist'].freeze

SPROCKETS_IGNORE = {
  development: ['javascripts/webpack/*'],
  production: [
    'templates/*', 'javascripts/webpack/*'
  ]
}.freeze

FAVICON_MAKER_OPTIONS = { template_dir: 'source/images/', icons: { 'icon.png' => [
  { icon: 'apple-touch-icon-precomposed.png', size: '152x152' },
  { icon: 'favicon.png', size: '152x152' },
  { icon: 'favicon.ico', size: '64x64,32x32,24x24,16x16' }
] } }.freeze

WEBP_OPTIONS = {
  development: {
    conversion_options: {
      '**/*.png' => { lossless: true },
      '**/*.jpg' => { q: 100 },
      '**/*.gif' => { lossy: true }
    },
    verbose: false,
    allow_skip: false,
    run_before_build: true
  },
  production: {
    conversion_options: {
      '**/*.png' => { lossless: true },
      '**/*.jpg' => { q: 100 },
      '**/*.gif' => { lossy: true }
    },
    allow_skip: false,
    run_before_build: false
  }
}.freeze

# configure Google Analytics tracking id in order to enable: eabled if not "UA-xxx-xxx-xx"
GOOGLE_ANALYTICS_OPTIONS = { tracking_id: 'UA-xxx-xxx-xx' }.freeze

# Per-page layout changes
['/*.xml', '/*.json', '/*.txt'].each { |file| page file, layout: false }

['/404.html', '/403.html'].each { |file| page file, layout: false, directory_index: false }

set :markdown_engine, :kramdown
set :markdown, auto_ids: false


# Activate Middleman extensions
ENABLE_EXTENSIONS_NO_OPTS[config[:environment]].each { |extension| activate extension }

activate :livereload, no_swf: true, host: '127.0.0.1'

activate :webp, WEBP_OPTIONS[config[:environment]]

# Add sprockets import paths
SPROCKETS_IMPORT_PATHS.each { |path| sprockets.append_path "#{root}/#{path}" }

# Ignore files or paths with middlemans own pipeline (they're handled by webpack)
SPROCKETS_IGNORE[config[:environment]].each { |file| ignore file }

# Webpack external pipline config
activate :external_pipeline, WEBPACK_OPTIONS

config[:host] = HOST_CONFIG[config[:environment]]

# Helpers
#
helpers do
  include ResponsiveEmbed
  include PictureTag
end

configure :build do
  activate :favicon_maker, FAVICON_MAKER_OPTIONS
  set :relative_links, true

  if GOOGLE_ANALYTICS_OPTIONS[:tracking_id] != 'UA-xxx-xxx-xx'
    activate :google_analytics, GOOGLE_ANALYTICS_OPTIONS
  end
end
