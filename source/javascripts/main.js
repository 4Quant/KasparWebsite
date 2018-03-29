import JumpWithSmoothScroll from './inc/JumpWithSmoothScroll'
import HamburgerMenu from './inc/HamburgerMenu'
import SlickInit from './inc/SlickInit'
import ScrollRevealer from './inc/ScrollRevealer'
import LoadLazyLoader from './inc/LoadLazyLoader'

// window onload trigger
$(() => {
  HamburgerMenu()
  SlickInit()
  LoadLazyLoader()
  JumpWithSmoothScroll()
  ScrollRevealer()
})
