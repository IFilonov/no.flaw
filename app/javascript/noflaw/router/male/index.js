import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

import Settings from '../../components/shared/settings';
import Dates from '../../components/male/dates';
import Pair from '../../components/shared/pair';
import Tasks from '../../components/shared/tasks';
import Tasks_manage from '../../components/shared/tasks_manage';
import Tasks_execute from '../../components/shared/tasks_execute';

export default new VueRouter( {
  mode: 'history',
  hashbang: false,
  routes: [
    { path: '/', redirect: '/males/settings'},
    { path: '/males/settings', component: Settings, name: 'Settings',
      children: [
        { path: 'new', component: Pair, name: 'PairNew'},
        { path: 'edit', component: Pair, name: 'PairEdit'},
        { path: 'delete', component: Pair, name: 'PairDelete'},
        { path: 'change', component: Pair, name: 'PairChange'},
        { path: 'revert', component: Pair, name: 'PairRevert'}
      ]},
    { path: '/males/dates', component: Dates, name: 'Dates'},
    { path: '/males/tasks', redirect: {name: 'Tasks_manage'}, component: Tasks, name: 'Tasks',
      children: [
        { path: '', component: Tasks_manage, name: 'Tasks_manage'},
        { path: 'execute', component: Tasks_execute, name: 'Tasks_execute'}
      ]}
  ]
})