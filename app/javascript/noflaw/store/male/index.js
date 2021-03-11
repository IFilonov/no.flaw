import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate';
import modulePair from '../modules/modulePair'

Vue.use(Vuex)

export default new Vuex.Store(  {
  state: {
    male_pair_image: "/female.jpg",
    male_image: "/male.jpg"
  },
  getters: {
    image: (state) => (pair) => {
      return pair ? state.male_pair_image : state.male_image
    }
  },
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
    updatePair: (context, pair) => {
      return Vue.prototype.$api.male.updatePair(pair)
        .then(({ data }) => {
          context.commit('CHANGE_NAMES', data)
          return data
        });
    },
    restorePair: (context, pair) => {
      return Vue.prototype.$api.male.restorePair(pair)
        .then(({ data }) => {
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
