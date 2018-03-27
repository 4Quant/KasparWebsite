import loadLazyloader from './inc/loadLazyloader';
import jumpWidthSmoothScroll from './inc/jumpWidthSmoothScroll';

$(() => {
  hamburger();
  slider();
  loadLazyloader();
  jumpWidthSmoothScroll();
});

const slider = () => {
  $('.slicker-slider').slick({
    dots: true,
    infinite: true,
    speed: 300,
    slidesToShow: 1,
    adaptiveHeight: false
  });
}

const hamburger = () => {
  const navToggler = $('header.header .navbar-toggler');
  const mobileNav = $('.hamburger-nav');
  $(navToggler, mobileNav).on('click', () => toggleHamburger());
  const toggleHamburger = () => mobileNav.toggleClass('hamburger-nav-open');
}
