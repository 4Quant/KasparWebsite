const slider = (selector) => $(selector).slick({
  dots: true,
  infinite: true,
  speed: 300,
  slidesToShow: 1,
  adaptiveHeight: false
});

export default slider;
