require 'slim'

# Global configs via CONSTANTS
#

HOST_CONFIG = { development: 'http://localhost:4567', production: 'https://4quant.gitlab.io' }.freeze

# Extensions that dont need any options
ENABLE_EXTENSIONS_NO_OPTS = {
  development: [:directory_indexes, :autoprefixer, :sprockets, :livereload, :pry],
  production: [:directory_indexes, :autoprefixer, :sprockets, :minify_css, :minify_javascript, :gzip]
}.freeze

WEBPACK_COMMAND = { production: 'production --bail', development: 'development --watch -d' }.freeze
WEBPACK_OPTIONS = {
  name: :webpack, source: '.tmp/dist', latency: 1,
  command: "./node_modules/webpack/bin/webpack.js --mode #{WEBPACK_COMMAND[config[:environment]]}"
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

SPROCKETS_IGNORE = {
  development: ['javascripts/main.js', 'javascripts/inc/*'],
  production: [
    'templates/*', 'javascripts/main.js', 'javascripts/main.bundle.js', 'javascripts/inc/*'
  ]
}.freeze

SPROCKETS_IMPORT_PATHS = ['node_modules'].freeze

# configure Google Analytics tracking id in order to enable: eabled if not "UA-xxx-xxx-xx"
GOOGLE_ANALYTICS_OPTIONS = { tracking_id: 'UA-xxx-xxx-xx' }.freeze

# Per-page layout changes
['/*.xml', '/*.json', '/*.txt'].each { |file| page file, layout: false }

['/404.html', '/403.html'].each { |file| page file, layout: false, directory_index: false }

set :markdown_engine, :kramdown
set :markdown, auto_ids: false


# Activate Middleman extensions
ENABLE_EXTENSIONS_NO_OPTS[config[:environment]].each { |extension| activate extension }

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
  # responsive google slide
  #
  def google_slide(link, aspect = '16by9')
    aspect = '16by9' unless ['16by9', '21by9', '4by3', '1by1'].include?(aspect)
    partial('partials/responsive_google_slide', locals: { aspect: aspect, src: link })
  end

  # youtube video responsive embed
  #
  # link:
  #   'https://youtu.be/G30HGR7AVHY', 'https://www.youtube.com/embed/-zHIUqm7Uwk',
  #   'https://www.youtube.com/embed/H2rTecSO0gk', '-zHIUqm7Uwk'
  # aspect:
  #   '16by9', '21by9', '4by3', '1by1'
  #
  def youtube(link, aspect = '16by9')
    aspect = '16by9' unless ['16by9', '21by9', '4by3', '1by1'].include?(aspect)
    partial('partials/responsive_youtube',
      locals: { video_id: extract_youtube_video_id(link), aspect: aspect })
  end

  def extract_youtube_video_id(link)
    uri = Addressable::URI.parse(link)
    return link unless ['www.youtube.com', 'youtu.be', 'youtube.com'].include?(uri.hostname)
    return uri.path[1..-1] if uri.hostname == 'youtu.be'
    return uri.query_values['v'] if uri.path == '/watch'
    uri.path.split('/')[-1] if uri.path.include? '/embed/'
  end

  # picture tag for webp images with fallback to img
  #
  # lazy: true => enables lazy loading for the image
  def picture(image, html_attributes)
    if image[0..3] == 'http'
      return image_tag(image, html_attributes)
    end
    path = image_path(image)
    content_tag(:picture, "#{webp_source_tag(path)}#{custom_image_tag(path, html_attributes)}", html_attributes)
  end

  def custom_image_tag(path, html_attributes)
    tag(:img, data: { src: path }, alt: html_attributes[:alt])
  end

  def webp_source_tag(path)
    return if development?
    webp = "#{File.dirname(path)}/#{File.basename(path, File.extname(path))}.webp"
    tag(:source, data: { srcset: webp }, type: 'image/webp')
  end
end

configure :build do
  activate :favicon_maker, FAVICON_MAKER_OPTIONS
  set :relative_links, true

  if GOOGLE_ANALYTICS_OPTIONS[:tracking_id] != 'UA-xxx-xxx-xx'
    activate :google_analytics, GOOGLE_ANALYTICS_OPTIONS
  end
end

# copy webpack built js file into build dir
after_build do
  system 'cat .tmp/dist/javascripts/main.bundle.js >> build/javascripts/app.js'
  system 'gzip -c build/javascripts/app.js > build/javascripts/app.js.gz'
end
