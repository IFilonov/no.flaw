import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate';

Vue.use(Vuex)

export default new Vuex.Store(  {
  state: {
    male_name: ''
  },
  mutations: {
    CHANGE_MALE_NAME: (state, male_name) => {
      state.male_name  = male_name;
    }
  },
  actions: {
    setMaleName: (context, data) => {
      context.commit('CHANGE_MALE_NAME', data);
    }
  },
  modules: {},
  plugins: [createPersistedState()]
})
