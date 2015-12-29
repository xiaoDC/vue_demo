Firebase = require 'firebase'
{ EventEmitter } = require 'events'
{ Promise } = require 'es6-promise'

api = new Firebase('https://hacker-news.firebaseio.com/v0')
itemsCache = Object.create(null)
store = new EventEmitter()
storiesPerPage = store.storiesPerPage = 30

topStoryIds = []

module.exports = store


api.child('topstories')
  .on 'value', (snapshot)->
    topStoryIds = snapshot.val()
    store.emit('topstories-updated')

store.fetchItem = (id)->
  new Promise (resolve, reject)->
    if (itemsCache[id])
      resolve(itemsCache[id])
    else
      api.child('item/' + id)
        .once 'value', (snapshot)->
          story = itemsCache[id] = snapshot.val()
          resolve(story)
        , reject
    return

store.fetchItems = (ids)->
  if (not ids or not ids.length)
    Promise.resolve []
  else
    Promise.all( ids.map (id)-> store.fetchItem(id) )


store.fetchItemsByPage = (page)->
  start = (page - 1) * storiesPerPage
  end = page * storiesPerPage
  ids = topStoryIds.slice(start, end)
  store.fetchItems ids


store.fetchUser = (id)->
  succeess = (resolve, reject) ->
    api.child('user/' + id)
      .once 'value', (snapshot) ->
        resolve snapshot.val()

  new Promise succeess, reject
