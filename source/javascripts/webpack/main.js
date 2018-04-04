import JumpWithSmoothScroll from './JumpWithSmoothScroll'
import HamburgerMenu from './HamburgerMenu'
import SlickInit from './SlickInit'
import ScrollRevealer from './ScrollRevealer'
import LoadLazyLoader from './LoadLazyLoader'
import ScrollSlider from './ScrollSlider'

// window onload trigger
$(() => {
  HamburgerMenu()
  SlickInit()
  LoadLazyLoader()
  JumpWithSmoothScroll()
  ScrollRevealer()
  ScrollSlider()
})
