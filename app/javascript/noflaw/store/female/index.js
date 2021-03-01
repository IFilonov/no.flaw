import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate';
import modulePair from '../modules'

Vue.use(Vuex)

export default new Vuex.Store(  {
  state: {
    me: {},
    pair: {},
    taboo_dates: [],
    fire_dates: {},
    pair_fire_dates: {}
  },
  getters: {
    getPair: state => {
      let pair = state.pair
      pair.nickname ||= pair.username
      return pair
    },
    getMe: state => {
      return state.me
    },
    pairFireDays: state => {
      return Object.keys(state.pair_fire_dates)
    },
    fireDays: state => {
      return Object.keys(state.fire_dates)
    },
    fireDayTime: state => (day) => {
      return state.fire_dates[day]
    },
    pairFireDayTime: state => (day) => {
      return state.pair_fire_dates[day]
    },
    fireDatesSer: state => {
      return state.fire_dates ? JSON.stringify(state.fire_dates) : [];
    },
    tabooDays: state => {
      return state.taboo_dates
    },
    tabooDatesSer: state => {
      return state.taboo_dates ? JSON.stringify(state.taboo_dates) : [];
    }
  },
  mutations: {
    CHANGE_NAMES: (state, data) => {
      if (!data.error) {
        state.pair = data.pair
        state.me = data.me
      }
    },
    CHANGE_DATES_SER: (state, data) => {
      state.taboo_dates = data.taboo_dates ? JSON.parse(data.taboo_dates) : []
      state.fire_dates = data.fire_dates ? JSON.parse(data.fire_dates) : {}
      state.pair_fire_dates = data.pair_fire_dates ? JSON.parse(data.pair_fire_dates) : {}
    },
    CHANGE_FIRE_DAYS: (state, fire_days) => {
      state.fire_dates = fire_days
        ?  Object.fromEntries(fire_days?.map(fire_day => ([ fire_day, state.fire_dates[fire_day] || {} ] ))) : {}
    },
    CHANGE_FIRE_TIME: (state, fire_date) => {
      state.fire_dates[fire_date.day] = fire_date.time
    },
    CHANGE_TABOO_DATES: (state, taboo_dates) => {
      state.taboo_dates  = taboo_dates;
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
      return Vue.prototype.$api.female.dates()
        .then(({data}) => (context.commit('CHANGE_DATES_SER', data)));
    },
    loadNames: (context) => {
      return Vue.prototype.$api.female.names()
          .then(({data}) => (context.commit('CHANGE_NAMES', data)));
    },
    setFireTime: (context, fire_date) => {
      context.commit('CHANGE_FIRE_TIME', fire_date);
    },
    addPair: (context, pair) => {
      return Vue.prototype.$api.female.addPair(pair)
          .then(({data}) => {
            context.commit('CHANGE_NAMES', data)
            return data
          });
    },
    setTabooDates: (context, taboo_dates) => {
      context.commit('CHANGE_TABOO_DATES', taboo_dates);
    }
  },
  modules: {
    pair: modulePair
  },
  plugins: [createPersistedState()]
})
