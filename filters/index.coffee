urlParser = document.createElement('a')

domain = (url)->
  urlParser.href = url
  urlParser.hostname


fromNow = (time)->
  between = Date.now() / 1000 - Number(time)
  if (between < 3600)
    pluralize(~~(between / 60), ' minute')
  else if (between < 86400)
    pluralize(~~(between / 3600), ' hour')
  else
    pluralize(~~(between / 86400), ' day')


pluralize = (time, label)->
  if time is 1
      return time + label

  (time + label + 's')

module.exports = {domain, fromNow}
