

export default () => {
  $('article.scroll').each((index, article) => {
    const scrollPhases = $(article).find('.scroll-phase')
    article.style.height = `${scrollPhases.length * 100}vh`
  });
}
