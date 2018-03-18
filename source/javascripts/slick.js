//= require slick-carousel/slick/slick.js

$(function() {
  $('.slicker-slider').slick({
    dots: true,
    infinite: true,
    speed: 300,
    slidesToShow: 1,
    adaptiveHeight: false
  });
});
