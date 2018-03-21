const loadLazyloader = () => {
  (function(w, d){
    const b = d.getElementsByTagName('body')[0];
    const s = d.createElement("script"); s.async = true;
    const v = !("IntersectionObserver" in w) ? "8.6.0" : "10.4.2";
    s.src = "https://cdnjs.cloudflare.com/ajax/libs/vanilla-lazyload/" + v + "/lazyload.min.js";
    w.lazyLoadOptions = {
      elements_selector: 'source[type="image/webp"],img'
    };
    s.addEventListener('load', () => {
      var myLazyLoad = new LazyLoad({
        elements_selector: 'source[type="image/webp"],img'
      });
    });
    b.appendChild(s);
  }(window, document));
}

export default loadLazyloader;