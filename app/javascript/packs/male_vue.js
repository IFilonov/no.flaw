import Vue from 'vue'
import App from '../noflaw/components/male/male.vue'
import '../noflaw/quasar'
import '../noflaw/api'
import router from '../noflaw/router/male'
import store from '../noflaw/store/male'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(App),
    router: router,
    store
  }).$mount()
  document.body.appendChild(app.$el)
})
