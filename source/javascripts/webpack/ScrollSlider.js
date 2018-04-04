
const gatherElements = (scrollElement) => {
  const article = $(scrollElement)
  const container = article.find('.container')
  const imgTarget = article.find('.img-target')
  const images = imgTarget.find('img').addClass('inactive').css({ order: 3 })
  const pinTarget = container.find('.pin-target')
  const duration = pinTarget.height() * images.length
  const partHeight = duration/(images.length+1)
  const triggerElement = article.find('.trigger')
  const offset = pinTarget.height()/2
  return { article, container, images, imgTarget, pinTarget, duration, partHeight, triggerElement, offset }
}

const createScene = ({ pinTarget, duration, triggerElement, offset }, controller) => {
  const scene = new ScrollMagic.Scene({ triggerElement, duration, offset })
  scene.setPin(pinTarget)
  scene.addTo(controller)
  return scene
}

const fadeInImg = ({ images }, part, { partImg, prevPartImg }) => {
  images.removeClass(['fade-in', 'fade-out']).css({ order: 3, marginLeft: 0 })
  $(prevPartImg).css({ order: 0 }).addClass('fade-out')
  $(partImg).css({ marginLeft: `-${$(partImg).width()}px`, order: 1 }).addClass(['fade-in']).on('animationend', ({target}) => {
    images.removeClass(['active', 'fade-in', 'fade-out']).addClass('inactive').css({ order: 3, marginLeft: 0 })
    $(target).css({ order: 0 }).removeClass('inactive').addClass('active')
  })
}

const sceneProgress = ({ progress, scrollDirection, state }, elements, sceneState) => {
  const part = Math.floor(progress*(elements.duration - 0.0001)/(elements.partHeight))
  if(part === sceneState.part) { return }
  sceneState.prevPartImg = sceneState.partImg
  sceneState.partImg = elements.images[part]
  fadeInImg(elements, part, sceneState)
  sceneState.part = part
}

export default () => {
  const controller = new ScrollMagic.Controller()
  const scenes = $('article.scroll').toArray().map((scrollElement) => {
    const elements = gatherElements(scrollElement)
    const scene = createScene(elements, controller)
    const sceneState = { part: 0, partImg: $(elements.images[0]).removeClass('inactive') }
    scene.on('progress', (sceneEvent) => sceneProgress(sceneEvent, elements, sceneState))
    return scene
  })
  return { controller, scenes }
}
