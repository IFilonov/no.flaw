import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate';

Vue.use(Vuex)

export default new Vuex.Store(  {
  state: {
    name: '',
    male_name: '',
    nickname: '',
    taboo_dates: [],
    fire_dates: {},
    male_fire_dates: {}
  },
  getters: {
    nickName: state => {
      return state.nickname ? state.nickname : state.female_name
    },
    maleFireDays: state => {
      return Object.keys(state.male_fire_dates)
    },
    fireDays: state => {
      return Object.keys(state.fire_dates)
    },
    fireDayTime: state => (day) => {
      return state.fire_dates[day]
    },
    pairFireDayTime: state => (day) => {
      return state.male_fire_dates[day]
    },
    fireDatesSer: state => {
      return state.fire_dates ? JSON.stringify(state.fire_dates) : [];
    },
    tabooDays: state => {
      return state.taboo_dates
    },
    tabooDatesSer: state => {
      return state.taboo_dates ? JSON.stringify(state.taboo_dates) : [];
    }
  },
  mutations: {
    CHANGE_NAMES: (state, data) => {
      state.name = data.name;
      state.male_name  = data.male_name;
      state.nickname  = data.nickname;
    },
    CHANGE_MALE_NAME: (state, data) => {
      state.male_name  = data.male_name;
    },
    CHANGE_TABOO_DATES: (state, taboo_dates) => {
      state.taboo_dates  = taboo_dates;
    },
    CHANGE_DATES_SER: (state, data) => {
      state.taboo_dates = data.taboo_dates ? JSON.parse(data.taboo_dates) : []
      state.fire_dates = data.fire_dates ? JSON.parse(data.fire_dates) : {}
      state.male_fire_dates = data.male_fire_dates ? JSON.parse(data.male_fire_dates) : {}
    },
    CHANGE_FIRE_DAYS: (state, fire_days) => {
      state.fire_dates = fire_days
        ?  Object.fromEntries(fire_days?.map(fire_day => ([ fire_day, state.fire_dates[fire_day] || {} ] ))) : {}
    },
    CHANGE_FIRE_TIME: (state, fire_date) => {
      state.fire_dates[fire_date.day] = fire_date.time
    }
  },
  actions: {
    setMaleName: (context, data) => {
      context.commit('CHANGE_MALE_NAME', data);
    },
    setNames: (context, data) => {
      context.commit('CHANGE_NAMES', data);
    },
    setTabooDates: (context, taboo_dates) => {
      context.commit('CHANGE_TABOO_DATES', taboo_dates);
    },
    setFireDays: (context, fire_days) => {
      context.commit('CHANGE_FIRE_DAYS', fire_days);
    },
    getDates: (context) => {
      return Vue.prototype.$api.female.dates()
        .then(({data}) => (context.commit('CHANGE_DATES_SER', data)));
    },
    getNames: (context) => {
      return Vue.prototype.$api.female.names()
          .then(({data}) => (context.commit('CHANGE_NAMES', data)));
    },
    setFireTime: (context, fire_date) => {
      context.commit('CHANGE_FIRE_TIME', fire_date);
    }
  },
  modules: {},
  plugins: [createPersistedState()]
})
