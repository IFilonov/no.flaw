import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

import Settings from '../components/male/settings';

export default new VueRouter( {
  mode: 'history',
  hashbang: false,
  routes: [
    { path: '/', redirect: '/males/settings'},
    { path: '/males/settings', component: Settings, name: 'Settings'},
  ]
})