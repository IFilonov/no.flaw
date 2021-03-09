import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate';
import modulePair from '../modules/modulePair'

Vue.use(Vuex)

export default new Vuex.Store(  {
  state: {
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
  },
  modules: {
    modulePair: modulePair
  },
  plugins: [createPersistedState()]
})
