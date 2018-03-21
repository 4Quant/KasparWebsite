require 'slim'
# Per-page layout changes
['/*.xml', '/*.json', '/*.txt'].each { |file| page file, layout: false }

['/404.html', '/403.html'].each { |file| page file, layout: false, directory_index: false }

page '/index.html', layout: :layout

set :markdown_engine, :kramdown
set :markdown, auto_ids: false

# Enable Google Analytics: Replace 'UA-xxx-xxx-xx' with your google tracking id
#
# activate :google_analytics do |ga|
#   ga.tracking_id = 'UA-xxx-xxx-xx'
# end

[:directory_indexes, :autoprefixer, :sprockets].each { |extension| activate extension }

["#{root}/node_modules/@ibm", "#{root}/node_modules"].each { |path| sprockets.append_path path }

['javascripts/main.js', 'javascripts/inc/*'].each { |file| ignore file }

webpack_command = {
  production: 'production --bail',
  development: 'development --watch -d'
}
activate :external_pipeline,
  name: :webpack,
  command: "./node_modules/webpack/bin/webpack.js --mode #{webpack_command[config[:environment]]}",
  source: '.tmp/dist',
  latency: 1


configure :development do
  config[:host] = 'http://localhost:4567'
  activate :livereload
  activate :pry

  activate :webp do |webp|
    webp.conversion_options = {
      '**/*.png' => { lossless: true },
      '**/*.jpg' => { q: 100 },
      '**/*.gif' => { lossy: true }
    }
    webp.run_before_build = true
    webp.allow_skip = false
  end
end

###
# Helpers
###

helpers do
  # picture tag for webp images with fallback to img
  #
  # lazy: true => enables lazy loading for the image
  def picture(image, lazy: false, html: { class: nil, data: nil, alt: nil, id: nil })
    path = image_path(image)
    content_tag(
      :picture,
      "#{webp_source_tag(path, lazy)}#{custom_image_tag(image, path, html, lazy)}",
      html
    )
  end

  def custom_image_tag(image, path, html, lazy = false)
    if lazy
      tag(:img, data: { src: path }, class: html[:class], id: html[:id], alt: html[:alt])
    else
      image_tag(image, html)
    end
  end

  def webp_source_tag(path, lazy)
    webp = "#{File.dirname(path)}/#{File.basename(path, File.extname(path))}.webp"
    if lazy
      tag(:source, data: { srcset: webp }, type: 'image/webp')
    else
      tag(:source, srcset: webp, type: 'image/webp')
    end
  end
end

configure :build do
  config[:host] = 'https://4quant.gitlab.io'
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

  activate :webp do |webp|
    webp.conversion_options = {
      '**/*.png' => { lossless: true },
      '**/*.jpg' => { q: 100 },
      '**/*.gif' => { lossy: true }
    }
    webp.allow_skip = false
  end

  [
    'templates/*', 'javascripts/main.js', 'javascripts/main.bundle.js', 'javascripts/inc/*'
  ].each do |file|
    ignore file
  end
  [:minify_css, :minify_javascript, :gzip].each { |extension| activate extension }

  set :relative_links, true
end

# copy webpack built js file into build dir
after_build do
  system 'cat .tmp/dist/javascripts/main.bundle.js >> build/javascripts/app.js'
  system 'gzip -c build/javascripts/app.js > build/javascripts/app.js.gz'
end
