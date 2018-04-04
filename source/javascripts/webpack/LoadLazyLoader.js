import LazyLoad8 from 'vanilla-lazyload-8'
import LazyLoad10 from 'vanilla-lazyload-10'

export default () => {
  const options = {
    elements_selector: 'source[type="image/webp"],img'
  }
  document.myLazyLoad = ('IntersectionObserver' in window) ? new LazyLoad10(options) : new LazyLoad8(options)
}
