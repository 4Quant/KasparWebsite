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
    arrows: false,
    mobileFirst: true,
    infinite: true,
    speed: 300,
    slidesToShow: 1,
    adaptiveHeight: false
  });
}

const hamburger = () => {
  const header = $('header.header');
  const navToggler = $('header.header .navbar-toggler');
  const mobileNav = $('.hamburger-nav');
  $(navToggler, mobileNav).on('click', () => toggleHamburger());
  const toggleHamburger = () => {
    header.toggleClass('shade-burger-nav-open')
    mobileNav.toggleClass('hamburger-nav-open');
  };
}
