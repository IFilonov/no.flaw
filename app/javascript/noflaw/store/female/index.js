import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate';

Vue.use(Vuex)

export default new Vuex.Store(  {
  state: {
    male_name: '',
    bad_dates: []
  },
  mutations: {
    CHANGE_MALE_NAME: (state, male_name) => {
      state.male_name  = male_name;
    },
    CHANGE_BAD_DATES: (state, dates) => {
      state.bad_dates  = dates;
    }
  },
  actions: {
    setMaleName: (context, data) => {
      context.commit('CHANGE_MALE_NAME', data);
    },
    setBadDates: (context, dates) => {
      context.commit('CHANGE_BAD_DATES', dates);
    }
  },
  modules: {},
  plugins: [createPersistedState()]
})
