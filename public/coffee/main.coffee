Vue = require 'vue'
Router = require 'vue-router'
{ domain, fromNow } = require '../../filters'


App = require '../../components/App.vue'
NewsView = require '../../components/NewsView.vue'
ItemView = require '../../components/ItemView.vue'
UserView = require '../../components/UserView.vue'

# install router
Vue.use Router

# register filters globally
Vue.filter 'fromNow', fromNow
Vue.filter 'domain', domain

# routing
router = new Router()

router.map {
  '/news/:page': {
    component: NewsView
  },
  '/user/:id': {
    component: UserView
  },
  '/item/:id': {
    component: ItemView
  }
}

router.beforeEach ->
  window.scrollTo(0, 0)

router.redirect
  '*': '/news/1'

router.start App, '#app'
