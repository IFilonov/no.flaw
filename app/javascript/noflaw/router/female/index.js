import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

import Settings from '../../components/female/settings';
import Dates from '../../components/female/dates';
import Pair from '../../components/shared/pair';

export default new VueRouter( {
  mode: 'history',
  hashbang: false,
  routes: [
    { path: '/', redirect: '/females/settings'},
    { path: '/females/settings', component: Settings, name: 'Settings',
      children: [
        { path: 'new', component: Pair, name: 'PairNew'},
        { path: 'edit', component: Pair, name: 'PairEdit'},
        { path: 'delete', component: Pair, name: 'PairDelete'}
      ]},
    { path: '/females/dates', component: Dates, name: 'Dates'}
  ]
})