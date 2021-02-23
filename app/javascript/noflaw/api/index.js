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
    info: () => adapter.get('/staffs/info')
  },
  male: {
    logout: '/males/logout',
    names: () => adapter.get('/males/info'),
    addFemale: (female) => adapter.post('/males/create', female),
    delFemale: () => adapter.get('/males/delete'),
    saveFireDate: (fire_date) => adapter.post('/males/set_fire_date', fire_date),
    dates: () => adapter.get('/males/dates')
  },
  female: {
    logout: '/females/logout',
    names: () => adapter.get('/females/info'),
    addMale: (male) => adapter.post('/females/create', male),
    delMale: () => adapter.get('/females/delete'),
    saveTabooDate: (taboo_date) => adapter.post('/females/set_taboo_date', taboo_date),
    saveFireDate: (fire_date) => adapter.post('/females/set_fire_date', fire_date),
    dates: () => adapter.get('/females/dates')
  }
}

Vue.prototype.$api = api
