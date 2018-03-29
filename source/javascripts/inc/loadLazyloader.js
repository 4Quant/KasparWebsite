import LazyLoad8 from 'vanilla-lazyload-8';
import LazyLoad10 from 'vanilla-lazyload-10';

const LoadLazyLoader = () => {
  (function(window, document) {
    const options = {
      elements_selector: 'source[type="image/webp"],img'
    }
    window.lazyLoadOptions = options;
    const myLazyLoad = ("IntersectionObserver" in window) ? new LazyLoad10(options) : new LazyLoad8(options);
  }(window, document));
}

export default LoadLazyLoader;
