import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate';

Vue.use(Vuex)

export default new Vuex.Store(  {
  state: {
    male_name: '',
    taboo_dates: [],
    fire_dates: []
  },
  getters: {
    fireDates: state => {
      return state.fire_dates
    },
    fireDatesSer: state => {
      return state.fire_dates ? JSON.stringify(state.fire_dates) : [];
    },
    tabooDates: state => {
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
      state.taboo_dates = data.taboo_dates ? JSON.parse(data.taboo_dates) : null
      state.fire_dates = data.fire_dates ? JSON.parse(data.fire_dates) : null
    },
    CHANGE_FIRE_DATES: (state, fire_dates) => {
      state.fire_dates  = fire_dates ? fire_dates.map(fire_date => ({ date: fire_date})) : []
    },
    CHANGE_FIRE_TIME: (state, fire_time) => {
      Vue.set(state.fire_dates[fire_time.index], 'time', fire_time.time)
    }
  },
  actions: {
    setMaleName: (context, data) => {
      context.commit('CHANGE_MALE_NAME', data);
    },
    setTabooDates: (context, taboo_dates) => {
      context.commit('CHANGE_TABOO_DATES', taboo_dates);
    },
    setFireDates: (context, fire_dates) => {
      context.commit('CHANGE_FIRE_DATES', fire_dates);
    },
    getDates: (context) => {
      return Vue.prototype.$api.female.dates()
        .then(({data}) => (context.commit('CHANGE_DATES_SER', data)));
    },
    setFireTime: (context, fire_time) => {
      context.commit('CHANGE_FIRE_TIME', fire_time);
    }
  },
  modules: {}//,
  //plugins: [createPersistedState()]
})
