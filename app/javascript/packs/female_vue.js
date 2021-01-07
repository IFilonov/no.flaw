import Vue from 'vue'
import App from '../noflaw/components/female/female.vue'
import '../noflaw/quasar'
import '../noflaw/api'
import router from '../noflaw/router/female'
import store from '../noflaw/store/female'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(App),
    router: router,
    store
  }).$mount()
  document.body.appendChild(app.$el)
})
