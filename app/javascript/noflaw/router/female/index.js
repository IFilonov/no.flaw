import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

import Settings from '../../components/shared/settings';
import Dates from '../../components/female/dates';
import Pair from '../../components/shared/pair';
import Tasks from '../../components/shared/tasks';

export default new VueRouter( {
  mode: 'history',
  hashbang: false,
  routes: [
    { path: '/', redirect: '/females/settings'},
    { path: '/females/settings', component: Settings, name: 'Settings',
      children: [
        { path: 'new', component: Pair, name: 'PairNew'},
        { path: 'edit', component: Pair, name: 'PairEdit'},
        { path: 'delete', component: Pair, name: 'PairDelete'},
        { path: 'change', component: Pair, name: 'PairChange'},
        { path: 'revert', component: Pair, name: 'PairRevert'}
      ]},
    { path: '/females/dates', component: Dates, name: 'Dates'},
    { path: '/females/tasks', component: Tasks, name: 'Tasks'}
  ]
})