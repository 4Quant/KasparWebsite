import SmoothScroll from 'smooth-scroll'

const JumpWithSmoothScroll = () => {
  return new SmoothScroll('a[href*="#"]', {
    header: 'header.header',
    speed: 500,
    easing: 'easeInOutCubic'
  })
}

export default JumpWithSmoothScroll
