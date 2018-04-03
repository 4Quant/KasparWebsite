// import ScrollMagic from 'scrollmagic'
import TweenMax from 'gsap'

export default () => {
  $('article.scroll').each((index, scrollElement) => {
    const article = $(scrollElement)
    const container = article.find('.container')
    const imageSrcs = article.find('.scroll-images img').toArray().map((img) => img.src)
    const pinTarget = container.find('.pin-target')
    const scrollTargetImg = pinTarget.find('.scroll-target-img')
    const trigger = article.find('.trigger')

    const scrollHeight = pinTarget.height() * imageSrcs.length

    article.height(`${article.height() + scrollHeight}px`)
    console.log(`${scrollHeight}px`)

    var obj = {curImg: 0};

    const tween = TweenMax.to(obj, 0.5, {
        curImg: imageSrcs.length - 1,	// animate propery curImg to number of images
        roundProps: "curImg",				// only integers so it can be used as an array index
        immediateRender: true,			// load first image automatically
        ease: Linear.easeNone,			// show every image the same ammount of time
        onUpdate: function () {
          scrollTargetImg.attr("src", imageSrcs[obj.curImg]); // set the image source
        }
      })

    const controller = new ScrollMagic.Controller()
    const scene = new ScrollMagic.Scene({
        offset: $(pinTarget).height() * 0.5,
        triggerElement: trigger,
        duration: scrollHeight
      })
      .setPin(pinTarget)
      .setTween(tween)
      .addTo(controller)
  });
}
