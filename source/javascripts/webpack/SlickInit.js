export default () => {
  const options = {
    dots: true,
    arrows: false,
    mobileFirst: true,
    infinite: true,
    speed: 300,
    slidesToShow: 1,
    adaptiveHeight: false
  }
  $('.slicker-slider').slick(options)
}
