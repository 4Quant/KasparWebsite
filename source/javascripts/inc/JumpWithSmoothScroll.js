import SmoothScroll from 'smooth-scroll';

const JumpWithSmoothScroll = () => {
  const scroll = new SmoothScroll('a[href*="#"]', {
    header: 'header.header',
    speed: 500,
    easing: 'easeInOutCubic'
  });
}

export default JumpWithSmoothScroll;
