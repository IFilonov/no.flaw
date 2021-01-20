import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate';

Vue.use(Vuex)

export default new Vuex.Store(  {
  state: {
    male_name: '',
    taboo_dates: []
  },
  mutations: {
    CHANGE_MALE_NAME: (state, male_name) => {
      state.male_name  = male_name;
    },
    CHANGE_TABOO_DATES: (state, taboo_dates) => {
      state.taboo_dates  = taboo_dates;
    },
    CHANGE_DATES_SER: (state, data) => {
      state.taboo_dates = data.taboo_dates ? JSON.parse(data.taboo_dates).map(date => JSON.parse(date)) : null;
      state.fire_dates = data.fire_dates ? JSON.parse(data.fire_dates).map(date => JSON.parse(date)): null;
    },
    CHANGE_FIRE_DATES: (state, fire_dates) => {
      state.fire_dates  = fire_dates;
    }
  },
  actions: {
    setMaleName: (context, data) => {
      context.commit('CHANGE_MALE_NAME', data);
    },
    setTabooDate: (context, taboo_dates) => {
      context.commit('CHANGE_TABOO_DATES', taboo_dates);
    },
    setFireDate: (context, fire_dates) => {
      context.commit('CHANGE_FIRE_DATES', fire_dates);
    },
    dates: (context) => {
      return Vue.prototype.$api.female.dates()
        .then(({data}) => (context.commit('CHANGE_DATES_SER', data)));
    }
  },
  modules: {},
  plugins: [createPersistedState()]
})
