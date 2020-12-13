import Vue from 'vue'
import App from '../noflaw/components/female/female.vue'
import '../noflaw/quasar'
import '../noflaw/api'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)
})
