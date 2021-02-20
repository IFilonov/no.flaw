import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate';

Vue.use(Vuex)

export default new Vuex.Store(  {
  state: {
    name: '',
    female_name: '',
    taboo_dates: [],
    fire_dates: {},
    female_fire_dates: {}
    },
  getters: {
    femaleFireDays: state => {
      return Object.keys(state.female_fire_dates)
    },
    femaleEvents: state => {
      return Object.keys(state.female_fire_dates)
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
    CHANGE_NAMES: (state, data) => {
      state.name = data.name;
      state.female_name  = data.female_name;
    },
    CHANGE_FEMALE_NAME: (state, data) => {
      state.female_name  = data.female_name;
    },
    CHANGE_DATES_SER: (state, data) => {
      state.taboo_dates = data.taboo_dates ? JSON.parse(data.taboo_dates) : []
      state.female_fire_dates = data.female_fire_dates ? JSON.parse(data.female_fire_dates) : {}
    }
  },
  actions: {
    setFemaleName: (context, data) => {
      context.commit('CHANGE_FEMALE_NAME', data);
    },
    setNames: (context, data) => {
      context.commit('CHANGE_NAMES', data);
    },
    getDates: (context) => {
      return Vue.prototype.$api.male.dates()
          .then(({data}) => (context.commit('CHANGE_DATES_SER', data)));
    },
    getNames: (context) => {
      return Vue.prototype.$api.male.names()
          .then(({data}) => (context.commit('CHANGE_NAMES', data)));
    }
  },
  modules: {},
  plugins: [createPersistedState()]
})
