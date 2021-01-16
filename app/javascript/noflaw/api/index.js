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
    info: () => adapter.get('/males/info'),
    addFemale: (female) => adapter.post('/females/create', female),
    delFemale: () => adapter.get('/females/delete')
  },
  female: {
    logout: '/females/logout',
    info: () => adapter.get('/females/info'),
    addMale: (male) => adapter.post('/males/create', male),
    delMale: () => adapter.get('/males/delete'),
    setTabooDates: (taboo_date) => adapter.post('/females/set_taboo_dates', taboo_date),
    tabooDates: () => adapter.get('/females/taboo_dates'),
  }
}

Vue.prototype.$api = api
