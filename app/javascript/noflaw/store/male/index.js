import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate';

Vue.use(Vuex)

export default new Vuex.Store(  {
  state: {
    female_name: '',
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
    CHANGE_FEMALE_NAME: (state, female_name) => {
      state.female_name  = female_name;
    },
    CHANGE_DATES_SER: (state, data) => {
      state.taboo_dates = data.taboo_dates ? JSON.parse(data.taboo_dates) : []
      state.fire_dates = data.fire_dates ? JSON.parse(data.fire_dates) : {}
    }
  },
  actions: {
    setFemaleName: (context, data) => {
      context.commit('CHANGE_FEMALE_NAME', data);
    },
    getDates: (context) => {
      return Vue.prototype.$api.male.dates()
          .then(({data}) => (context.commit('CHANGE_DATES_SER', data)));
    }
  },
  modules: {},
  plugins: [createPersistedState()]
})
