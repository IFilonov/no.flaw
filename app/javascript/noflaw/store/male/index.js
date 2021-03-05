import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate';
import modulePair from '../modules/modulePair'

Vue.use(Vuex)

export default new Vuex.Store(  {
  actions: {
    getDates: (context) => {
      return Vue.prototype.$api.male.dates()
        .then(({ data }) => (context.commit('CHANGE_DATES_SER', data)));
    },
    loadNames: (context) => {
      return Vue.prototype.$api.male.names()
          .then(({ data }) => (context.commit('CHANGE_NAMES', data)));
    },
    addPair: (context, pair) => {
      return Vue.prototype.$api.male.addPair(pair)
        .then(({ data }) => {
          context.commit('CHANGE_NAMES', data)
          return data
        });
    },
    getPairHistory: (context) => {
      return Vue.prototype.$api.male.pairHistory()
          .then(({ data }) => (context.commit('CHANGE_PAIR_HISTORY', data)));
    }
  },
  modules: {
    modulePair: modulePair
  },
  plugins: [createPersistedState()]
})
