import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate';

Vue.use(Vuex)

export default new Vuex.Store(  {
  state: {
    male_name: '',
    taboo_dates: [],
    fire_dates: {}
  },
  getters: {
    fireDays: state => {
      return Object.keys(state.fire_dates)
    },
    fireDayTime: state => (day) => {
      return state.fire_dates[day]
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
    CHANGE_MALE_NAME: (state, male_name) => {
      state.male_name  = male_name;
    },
    CHANGE_TABOO_DATES: (state, taboo_dates) => {
      state.taboo_dates  = taboo_dates;
    },
    CHANGE_DATES_SER: (state, data) => {
      state.taboo_dates = data.taboo_dates ? JSON.parse(data.taboo_dates) : []
      state.fire_dates = data.fire_dates ? JSON.parse(data.fire_dates) : {}
    },
    CHANGE_FIRE_DAYS: (state, fire_days) => {
      state.fire_dates = Object.fromEntries(fire_days?.map(fire_day => ([ fire_day, state.fire_dates[fire_day] ] )))
    },
    CHANGE_FIRE_TIME: (state, fire_date) => {
      state.fire_dates[fire_date.day] = fire_date.time
    }
  },
  actions: {
    setMaleName: (context, data) => {
      context.commit('CHANGE_MALE_NAME', data);
    },
    setTabooDates: (context, taboo_dates) => {
      context.commit('CHANGE_TABOO_DATES', taboo_dates);
    },
    setFireDays: (context, fire_days) => {
      context.commit('CHANGE_FIRE_DAYS', fire_days);
    },
    getDates: (context) => {
      return Vue.prototype.$api.female.dates()
        .then(({data}) => (context.commit('CHANGE_DATES_SER', data)));
    },
    setFireTime: (context, fire_date) => {
      context.commit('CHANGE_FIRE_TIME', fire_date);
    }
  },
  modules: {},
  plugins: [createPersistedState()]
})
