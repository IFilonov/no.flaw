import Vue from 'vue'
import axios from 'axios'

const token = document.head.querySelector('meta[name="csrf-token"]')
axios.defaults.headers.common['X-CSRF-TOKEN'] = token.content

const adapter = axios.create({
  headers: {
    Accept: 'application/json'
  }
})

const api = {
  staff: {
    logout: '/staffs/logout',
    user: () => adapter.get('/staffs/user')
  },
  male: {
    logout: '/males/logout',
    user: () => adapter.get('/males/user')
  },
  female: {
    logout: '/females/logout',
    user: () => adapter.get('/females/user')
  }
}

Vue.prototype.$api = api
