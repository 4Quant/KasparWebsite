const HamburgerMenu = () => {
  const header = $('header.header')
  const navToggler = $('header.header .navbar-toggler')
  const mobileNav = $('.hamburger-nav')
  $(navToggler, mobileNav).on('click', () => toggleHamburger())
  const toggleHamburger = () => {
    header.toggleClass('shade-burger-nav-open')
    mobileNav.toggleClass('hamburger-nav-open')
  }
}

export default HamburgerMenu
