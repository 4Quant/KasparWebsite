import JumpWithSmoothScroll from './inc/JumpWithSmoothScroll'
import HamburgerMenu from './inc/HamburgerMenu'
import SlickInit from './inc/SlickInit'
import ScrollRevealer from './inc/ScrollRevealer'
// import LoadLazyLoader from './inc/LoadLazyLoader'
import LazyLoad8 from 'vanilla-lazyload-8'
import LazyLoad10 from 'vanilla-lazyload-10'

const LoadLazyLoader = () => {
  (function (window, document) {
    const options = {
      elements_selector: 'source[type="image/webp"],img'
    }
    window.lazyLoadOptions = options
    document.myLazyLoad = ('IntersectionObserver' in window) ? new LazyLoad10(options) : new LazyLoad8(options)
  }(window, document))
}
// window onload trigger
$(() => {
  HamburgerMenu()
  SlickInit()
  LoadLazyLoader()
  JumpWithSmoothScroll()
  ScrollRevealer()
})
