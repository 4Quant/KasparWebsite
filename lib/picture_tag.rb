require 'fastimage'
require 'open-uri'

module PictureTag
  # picture tag for webp images with fallback to img
  #
  # lazy: true => enables lazy loading for the image
  def picture(image, html_attributes = {})
    external = image[0..3] == 'http'
    path = external ? download_external_image(image) : image_path(image)
    content_tag(:picture,
      "#{webp_source_tag(path)}#{custom_image_tag(path, html_attributes)}", html_attributes)
  end

  def custom_image_tag(path, html_attributes)
    tag(:img, data: { src: path }, alt: html_attributes[:alt])
  end

  def webp_source_tag(path)
    webp = webp_source_image(path)
    tag(:source, data: { srcset: webp }, type: 'image/webp') if webp
  end

  def webp_source_image(path)
    webp = "#{File.dirname(path)}/#{File.basename(path, File.extname(path))}.webp"
    return webp if File.exist?("source#{webp}")
    return webp if convert_to_webp("source#{path}", "source#{webp}")
    false
  end

  def convert_to_webp(source, dest)
    if ['.png', '.jpg', '.jpeg'].include?(File.extname(source))
      system "cwebp -lossless '#{source}' -o '#{dest}'"
    elsif File.extname(source) == '.gif'
      system "gif2webp -lossy '#{source}' -o '#{dest}'"
    else
      false
    end
  end

  def download_external_image(uri)
    page_path = current_page.path[0..-6]
    type = FastImage.type(uri)
    uri_parsed = URI.parse(uri)
    localized_image_path = "#{page_path}/#{uri_parsed.host}_#{uri_parsed.path.tr('/', '_')}.#{type}"
    return image_path(localized_image_path) if File.exist?("source/#{localized_image_path}")
    destination_path = "source/images/#{page_path}"
    system "mkdir -p #{destination_path}" unless Dir.exist?(destination_path)
    open("source/images/#{localized_image_path}", 'wb') do |file|
      file << open(uri).read
    end
    image_path(localized_image_path)
  end

  def get_external_img_for_webp(uri)
    page_path = current_page.path[0..-6]
    type = FastImage.type(uri)
    uri_parsed = URI.parse(uri)
    original = "images/#{page_path}/#{uri_parsed.host}_#{uri_parsed.path.tr('/', '_')}."
    return "#{original}#{type}" if File.exist?("source/#{original}#{type}")
    destination_path = "source/#{page_path}"
    system "mkdir -p #{destination_path}" unless Dir.exist?(destination_path)
    open("source/#{original}#{type}", 'wb') do |file|
      file << open(uri).read
    end
    "#{original}webp" if convert_to_webp("source/#{original}#{type}", "source/#{original}webp")
  end
end
