import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

import Settings from '../../components/female/settings';

export default new VueRouter( {
  mode: 'history',
  hashbang: false,
  routes: [
    { path: '/', redirect: '/females/settings'},
    { path: '/females/settings', component: Settings, name: 'Settings'}
  ]
})