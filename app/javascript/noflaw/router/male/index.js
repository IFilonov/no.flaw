import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

import Settings from '../../components/male/settings';
import Dates from '../../components/male/dates';
import Pair from '../../components/shared/pair';

export default new VueRouter( {
  mode: 'history',
  hashbang: false,
  routes: [
    { path: '/', redirect: '/males/settings'},
    { path: '/males/settings', component: Settings, name: 'Settings',
      children: [
        { path: ':new', component: Pair, name: 'Pair'}
      ]},
    { path: '/males/dates', component: Dates, name: 'Dates'}
  ]
})