import LoadLazyLoader from './inc/LoadLazyLoader';
import JumpWithSmoothScroll from './inc/JumpWithSmoothScroll';
import HamburgerMenu from './inc/HamburgerMenu';
import SlickInit from './inc/SlickInit';

// window onload trigger
$(() => {
  HamburgerMenu();
  SlickInit();
  LoadLazyLoader();
  JumpWithSmoothScroll();
});
