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
    CHANGE_TABOO_DATES_ARR: (state, taboo_dates) => {
      state.taboo_dates  = taboo_dates;
    },
    CHANGE_TABOO_DATES_SER: (state, data) => {
      try{
        state.taboo_dates = JSON.parse(data.taboo_dates).map(date => JSON.parse(date))
      }
      catch (err){
        state.taboo_dates  = null;
      }
    }
  },
  actions: {
    setMaleName: (context, data) => {
      context.commit('CHANGE_MALE_NAME', data);
    },
    setTabooDates: (context, taboo_dates) => {
      context.commit('CHANGE_TABOO_DATES_ARR', taboo_dates);
    },
    tabooDates: (context) => {
      return Vue.prototype.$api.female.tabooDates()
        .then(({data}) => (context.commit('CHANGE_TABOO_DATES_SER', data)));
    }
  },
  modules: {},
  plugins: [createPersistedState()]
})
