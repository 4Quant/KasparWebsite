module ResponsiveEmbed
  # responsive google slide
  #
  def google_slide(link, aspect = '16by9')
    aspect = '16by9' unless ['16by9', '21by9', '4by3', '1by1'].include?(aspect)
    partial('partials/responsive_google_slide', locals: { aspect: aspect, src: link })
  end

  # youtube video responsive embed
  #
  # link:
  #   It supports these url formats
  #     http://www.youtube.com/v/RCUkmUXMd_k
  #     http://www.youtube.com/v/RCUkmUXMd_k?version=3&amp;hl=en_US&amp;rel=0
  #     http://www.youtube.com/embed/RCUkmUXMd_k?rel=0
  #     http://www.youtube.com/watch?v=RCUkmUXMd_k
  #     http://www.youtube.com/watch?v=RCUkmUXMd_k&feature=related
  #     http://www.youtube.com/watch?v=RCUkmUXMd_k#t=0m10s
  #     http://www.youtube.com/user/ForceD3strategy#p/a/u/0/8WVTOUh53QY
  #     http://youtu.be/RCUkmUXMd_k
  #
  # aspect:
  #   '16by9', '21by9', '4by3', '1by1'
  #
  def youtube(link, aspect = '16by9')
    aspect = '16by9' unless ['16by9', '21by9', '4by3', '1by1'].include?(aspect)
    partial('partials/responsive_youtube',
      locals: { video_id: YoutubeID.from(link), aspect: aspect })
  end
end
