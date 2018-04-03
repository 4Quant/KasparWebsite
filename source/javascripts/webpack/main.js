import JumpWithSmoothScroll from './JumpWithSmoothScroll'
import HamburgerMenu from './HamburgerMenu'
import SlickInit from './SlickInit'
import ScrollRevealer from './ScrollRevealer'
import LoadLazyLoader from './LoadLazyLoader'
import ScrollDownAnimations  from './ScrollDownAnimations'

// window onload trigger
$(() => {
  HamburgerMenu()
  SlickInit()
  LoadLazyLoader()
  JumpWithSmoothScroll()
  // Uncomment to enable scroll revealing
  ScrollRevealer()
  ScrollDownAnimations()
})
