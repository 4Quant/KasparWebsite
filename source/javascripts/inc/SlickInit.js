
const SlickInit = () => {
  $('.slicker-slider').slick({
    dots: true,
    arrows: false,
    mobileFirst: true,
    infinite: true,
    speed: 300,
    slidesToShow: 1,
    adaptiveHeight: false
  });
}

export default SlickInit;
