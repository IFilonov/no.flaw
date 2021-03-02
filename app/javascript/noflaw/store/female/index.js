import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate';
import modulePair from '../modules/modulePair'

Vue.use(Vuex)

export default new Vuex.Store(  {
  state: {
  },
  mutations: {
    CHANGE_TABOO_DATES: (state, taboo_dates) => {
      state.taboo_dates  = taboo_dates;
    }
  },
  actions: {
    getDates: (context) => {
      return Vue.prototype.$api.female.dates()
        .then(({data}) => (context.commit('CHANGE_DATES_SER', data)));
    },
    loadNames: (context) => {
      return Vue.prototype.$api.female.names()
          .then(({data}) => (context.commit('CHANGE_NAMES', data)));
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
    modulePair: modulePair
  },
  plugins: [createPersistedState()]
})
