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

page '/404.html', layout: false, directory_index: false
page '/403.html', layout: false, directory_index: false

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

# Enable Google Analytics: Replace 'UA-xxx-xxx-xx' with your google tracking id
#
# activate :google_analytics do |ga|
#   ga.tracking_id = 'UA-xxx-xxx-xx'
# end

activate :directory_indexes
activate :autoprefixer




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

# Methods defined in the helpers block are available in templates
helpers do
  def news_paragraphs
    Dir['source/news/*.html.md']
      .map { |file| File.basename(file, '.html.md') }
      .sort.reverse
      .map { |file| [file, Date.parse(file)]}
  end

  def picture(image, lazy: false, html: { class: nil, data: nil, alt: nil, id: nil })
    path = image_path(image)
    tags = webp_source_tag(path, lazy)
    tags += if lazy
              lazy_img(path, html)
            else
              image_tag(image, html)
            end
    content_tag(:picture, tags, html)
  end

  def lazy_img(path, html)
    tag(:img, data: { src: path }, class: html[:class], id: html[:id], alt: html[:alt])
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
  activate :gzip

  activate :webp do |webp|
    webp.conversion_options = {
      '**/*.png' => { lossless: true },
      '**/*.jpg' => { q: 100 },
      '**/*.gif' => { lossy: true }
    }
    webp.allow_skip = false
  end
  set :relative_links, true
end

# copy webpack built js file into build dir
after_build do
  system 'cat .tmp/dist/javascripts/main.bundle.js >> build/javascripts/app.js'
  system 'gzip -c build/javascripts/app.js > build/javascripts/app.js.gz'
end
