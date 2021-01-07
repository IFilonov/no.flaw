import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate';

Vue.use(Vuex)

export default new Vuex.Store(  {
  state: {
    female_name: ''
  },
  mutations: {
    CHANGE_FEMALE_NAME: (state, female_name) => {
      state.female_name  = female_name;
    }
  },
  actions: {
    setFemaleName: (context, data) => {
      context.commit('CHANGE_FEMALE_NAME', data);
    }
  },
  modules: {},
  plugins: [createPersistedState()]
})
