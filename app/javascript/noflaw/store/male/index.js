import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate';
import modulePair from '../modules/modulePair'

Vue.use(Vuex)

export default new Vuex.Store(  {
  state: {
    me: {},
    pair: {},
    taboo_dates: [],
    fire_dates: {},
    pair_fire_dates: {}
    },
  mutations: {
    CHANGE_NAMES: (state, data) => {
      if (!data.error) {
        state.pair = data.pair;
        state.me = data.me;
      }
    },
    CHANGE_DATES_SER: (state, data) => {
      state.taboo_dates = data.taboo_dates ? JSON.parse(data.taboo_dates) : []
      state.pair_fire_dates = data.pair_fire_dates ? JSON.parse(data.pair_fire_dates) : {}
      state.fire_dates = data.fire_dates ? JSON.parse(data.fire_dates) : {}
    },
    CHANGE_FIRE_DAYS: (state, fire_days) => {
      state.fire_dates = fire_days
        ?  Object.fromEntries(fire_days?.map(fire_day => ([ fire_day, state.fire_dates[fire_day] || {} ] ))) : {}
    },
    CHANGE_FIRE_TIME: (state, fire_date) => {
      state.fire_dates[fire_date.day] = fire_date.time
    }
  },
  actions: {
    setNames: (context, data) => {
      context.commit('CHANGE_NAMES', data);
    },
    setFireDays: (context, fire_days) => {
      context.commit('CHANGE_FIRE_DAYS', fire_days);
    },
    getDates: (context) => {
      return Vue.prototype.$api.male.dates()
          .then(({data}) => (context.commit('CHANGE_DATES_SER', data)));
    },
    loadNames: (context) => {
      return Vue.prototype.$api.male.names()
          .then(({data}) => (context.commit('CHANGE_NAMES', data)));
    },
    setFireTime: (context, fire_date) => {
      context.commit('CHANGE_FIRE_TIME', fire_date);
    },
    addPair: (context, pair) => {
      return Vue.prototype.$api.male.addPair(pair)
        .then(({data}) => {
          context.commit('CHANGE_NAMES', data)
          return data
        });
    }
  },
  modules: {
    modulePair: modulePair
  },
  plugins: [createPersistedState()]
})
