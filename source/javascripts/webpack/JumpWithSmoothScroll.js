import SmoothScroll from 'smooth-scroll'

export default () => {
  return new SmoothScroll('a[href*="#"]', {
    header: 'header.header',
    speed: 500,
    easing: 'easeInOutCubic'
  })
}
