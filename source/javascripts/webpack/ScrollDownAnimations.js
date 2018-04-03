

export default () => {
  $('article.scroll').each((index, article) => {
    const scrollPhases = $(article).find('.scroll-phase')
    const container = $(article).find('.container')[0]
    container.style.height = `${scrollPhases.length * 100}vh`
  });
}
