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
    addPair: (female) => adapter.post('/males/create', female),
    updatePair: (female) => adapter.post('/males/update', female),
    restorePair: (female) => adapter.post('/males/restore', female),
    delPair: () => adapter.get('/males/delete'),
    saveFireDate: (fire_date) => adapter.post('/males/set_fire_date', fire_date),
    dates: () => adapter.get('/males/dates'),
    pairHistory: () => adapter.get('/males/pair_history')
  },
  female: {
    logout: '/females/logout',
    names: () => adapter.get('/females/info'),
    addPair: (male) => adapter.post('/females/create', male),
    updatePair: (male) => adapter.post('/females/update', male),
    delPair: () => adapter.get('/females/delete'),
    saveTabooDate: (taboo_date) => adapter.post('/females/set_taboo_date', taboo_date),
    saveFireDate: (fire_date) => adapter.post('/females/set_fire_date', fire_date),
    dates: () => adapter.get('/females/dates'),
    pairHistory: () => adapter.get('/females/pair_history')
  }
}

Vue.prototype.$api = api
