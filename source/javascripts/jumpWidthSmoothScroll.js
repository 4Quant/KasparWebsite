import SmoothScroll from 'smooth-scroll';

const jumpWidthSmoothScroll = () => {
  const scroll = new SmoothScroll('a[href*="#"]', {
    header: 'header.header',
    speed: 500,
    easing: 'easeInOutCubic'
  });
}

export default jumpWidthSmoothScroll;
