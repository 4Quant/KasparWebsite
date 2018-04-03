module PictureTag
  # picture tag for webp images with fallback to img
  #
  # lazy: true => enables lazy loading for the image
  def picture(image, html_attributes)
    external = image[0..3] == 'http'
    path = external ? image : image_path(image)
    content_tag(:picture,
      "#{webp_source_tag(path, external)}#{custom_image_tag(path, html_attributes)}", html_attributes)
  end

  def custom_image_tag(path, html_attributes)
    tag(:img, data: { src: path }, alt: html_attributes[:alt])
  end

  def webp_source_tag(path, external)
    return if development? || external
    webp = "#{File.dirname(path)}/#{File.basename(path, File.extname(path))}.webp"
    tag(:source, data: { srcset: webp }, type: 'image/webp')
  end
end
