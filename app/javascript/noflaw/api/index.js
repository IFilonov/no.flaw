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
    saveFireDate: (fire_date) => adapter.post('/lifetimes/set_fire_date', fire_date),
    dates: () => adapter.get('/males/dates')
  },
  female: {
    logout: '/females/logout',
    names: () => adapter.get('/females/info'),
    addPair: (male) => adapter.post('/females/create', male),
    updatePair: (male) => adapter.post('/females/update', male),
    saveTabooDate: (taboo_date) => adapter.post('/lifetimes/set_taboo_date', taboo_date),
    saveFireDate: (fire_date) => adapter.post('/lifetimes/set_fire_date', fire_date),
    dates: () => adapter.get('/females/dates')
  },
  pair: {
    delete: () => adapter.get('/pairs/delete'),
    restore: (pair) => adapter.post('/pairs/restore', pair),
    history: () => adapter.get('/pairs/history'),
    tasks: () => adapter.get('/tasks')
  }
}

Vue.prototype.$api = api
