import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate';
import modulePair from '../modules/modulePair'

Vue.use(Vuex)

export default new Vuex.Store(  {
  state: {
    female_pair_image: '/male.jpg',
    female_image: '/female.jpg'
  },
  getters: {
    image: (state) => (pair) => {
      return pair ? state.female_pair_image : state.female_image
    }
  },
  actions: {
    getDates: (context) => {
      return Vue.prototype.$api.female.dates()
        .then(({ data }) => (context.commit('CHANGE_DATES_SER', data)));
    },
    loadNames: (context) => {
      return Vue.prototype.$api.female.names()
        .then(({ data }) => (context.commit('CHANGE_NAMES', data)));
    },
    addPair: (context, pair) => {
      return Vue.prototype.$api.female.addPair(pair)
        .then(({ data }) => {
          context.commit('CHANGE_NAMES', data)
          return data
        });
    },
    updatePair: (context, pair) => {
      return Vue.prototype.$api.female.updatePair(pair)
        .then(({ data }) => {
          context.commit('CHANGE_NAMES', data)
          return data
        });
    },
    restorePair: (context, pair) => {
      return Vue.prototype.$api.female.restorePair(pair)
        .then(({ data }) => {
          context.commit('CHANGE_NAMES', data)
          return data
        });
    },
    setIssuedTask: (context, task) => {
      return Vue.prototype.$api.female.addIssuedTask(task)
        .then(({ data }) => {
          context.commit('CHANGE_TASKS', data)
          return data
        });
    }
  },
  modules: {
    modulePair: modulePair
  },
  plugins: [createPersistedState()]
})
