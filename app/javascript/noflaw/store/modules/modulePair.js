import Vue from "vue";

export default {
  state: {
    me: {},
    pair: {},
    recover_pair_id: null,
    pair_history: [],
    taboo_dates: [],
    fire_dates: {},
    pair_fire_dates: {}
  },
  getters: {
    getMe(state) {
      return state.me
    },
    getPair(state)  {
      let pair = state.pair
      pair.nickname ||= pair.username
      return pair
    },
    pairHistory(state) {
      return state.pair_history.filter(pair => pair.username !== state.pair.username)
    },
    pairFireDays(state)  {
      return Object.keys(state.pair_fire_dates)
    },
    fireDays(state)  {
      return Object.keys(state.fire_dates)
    },
    fireDayTime: (state) => (day) => {
      return state.fire_dates[day]
    },
    pairFireDayTime: (state) => (day) => {
      return state.pair_fire_dates[day]
    },
    fireDatesSer(state) {
      return state.fire_dates ? JSON.stringify(state.fire_dates) : [];
    },
    tabooDays(state) {
      return state.taboo_dates
    },
    tabooDatesSer(state) {
      return state.taboo_dates ? JSON.stringify(state.taboo_dates) : [];
    },
    getRecoverPairId(state) {
      return state.recover_pair_id
    }
  },
  mutations: {
    CHANGE_TABOO_DATES: (state, taboo_dates) => {
      state.taboo_dates = taboo_dates;
    },
    CHANGE_NAMES: ( state, data ) => {
      if (!data.error) {
        state.pair = data.pair
        state.me = data.me
      }
    },
    CHANGE_DATES_SER: (state, data) => {
      state.taboo_dates = data.taboo_dates ? JSON.parse(data.taboo_dates) : []
      state.fire_dates = data.fire_dates ? JSON.parse(data.fire_dates) : {}
      state.pair_fire_dates = data.pair_fire_dates ? JSON.parse(data.pair_fire_dates) : {}
    },
    CHANGE_FIRE_DAYS: (state, fire_days) => {
      state.fire_dates = fire_days
          ?  Object.fromEntries(fire_days?.map(fire_day => ([ fire_day, state.fire_dates[fire_day] || {} ] ))) : {}
    },
    CHANGE_FIRE_TIME: (state, fire_date) => {
      state.fire_dates[fire_date.day] = fire_date.time
    },
    CHANGE_PAIR_HISTORY: ( state, data ) => {
      if (!data.error) {
        state.pair_history = data
      }
    },
    RECOVER_PAIR_ID: (state, recover_pair_id) => {
      state.recover_pair_id = recover_pair_id
    }
  },
  actions: {
    setNames: (context, data) => {
      context.commit('CHANGE_NAMES', data);
    },
    setFireDays: (context, fire_days) => {
      context.commit('CHANGE_FIRE_DAYS', fire_days);
    },
    setFireTime: (context, fire_date) => {
      context.commit('CHANGE_FIRE_TIME', fire_date);
    },
    setRecoverPairId: (context, recover_pair_id) => {
      context.commit('RECOVER_PAIR_ID', recover_pair_id);
    },
    setTabooDates: (context, taboo_dates) => {
      context.commit('CHANGE_TABOO_DATES', taboo_dates);
    }
  }
}
