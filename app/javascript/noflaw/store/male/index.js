import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate';

Vue.use(Vuex)

export default new Vuex.Store(  {
  state: {
    me: {
      username: ''
    },
    pair: {
      username: '',
      nickname: '',
      password: ''
    },
    taboo_dates: [],
    fire_dates: {},
    female_fire_dates: {}
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
    femaleFireDays: state => {
      return Object.keys(state.female_fire_dates)
    },
    fireDays: state => {
      return Object.keys(state.fire_dates)
    },
    fireDayTime: state => (day) => {
      return state.fire_dates[day]
    },
    pairFireDayTime: state => (day) => {
      return state.female_fire_dates[day]
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
      state.pair = data.pair;
      state.me = data.me;
    },
    CHANGE_DATES_SER: (state, data) => {
      state.taboo_dates = data.taboo_dates ? JSON.parse(data.taboo_dates) : []
      state.female_fire_dates = data.female_fire_dates ? JSON.parse(data.female_fire_dates) : {}
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
    getDates: (context) => {
      return Vue.prototype.$api.male.dates()
          .then(({data}) => (context.commit('CHANGE_DATES_SER', data)));
    },
    loadNames: (context) => {
      return Vue.prototype.$api.male.names()
          .then(({data}) => (context.commit('CHANGE_NAMES', data)));
    },
    setFireDays: (context, fire_days) => {
      context.commit('CHANGE_FIRE_DAYS', fire_days);
    },
    setFireTime: (context, fire_date) => {
      context.commit('CHANGE_FIRE_TIME', fire_date);
    }
  },
  modules: {},
  plugins: [createPersistedState()]
})
