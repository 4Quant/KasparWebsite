import loadLazyloader from './loadLazyloader';
$(() => {
  hamburger();
  slider();
  loadLazyloader();
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
  const mobileNav = $('header.header .hamburger-nav');
  $(navToggler, mobileNav).on('click', () => toggleHamburger());
  const toggleHamburger = () => mobileNav.toggleClass('hamburger-nav-open');
}
