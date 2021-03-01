export default {
  state: {
  },
  getters: {
    getMe(state, getters, root_state) {
      return root_state.me
    },
    getPair(state, getters, root_state)  {
      let pair = root_state.pair
      pair.nickname ||= pair.username
      return pair
    },
    pairFireDays(state, getters, root_state)  {
      return Object.keys(root_state.pair_fire_dates)
    },
    fireDays(state, getters, root_state)  {
      return Object.keys(root_state.fire_dates)
    },
    fireDayTime: (state, getters, root_state) => (day) => {
      return root_state.fire_dates[day]
    },
    pairFireDayTime: (state, getters, root_state) => (day) => {
      return root_state.pair_fire_dates[day]
    },
    fireDatesSer(state, getters, root_state) {
      return root_state.fire_dates ? JSON.stringify(root_state.fire_dates) : [];
    },
    tabooDays(state, getters, root_state) {
      return root_state.taboo_dates
    },
    tabooDatesSer(state, getters, root_state) {
      return root_state.taboo_dates ? JSON.stringify(root_state.taboo_dates) : [];
    }
  }
}
