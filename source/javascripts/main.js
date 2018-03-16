$(() => {
  hamburger();
});

const hamburger = () => {
  const navToggler = $('header.header .navbar-toggler');
  const mobileNav = $('header.header .hamburger-nav');
  $(navToggler, mobileNav).on('click', () => toggleHamburger());
  const toggleHamburger = () => mobileNav.toggleClass('hamburger-nav-open');
}
