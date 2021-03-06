export default {
  DEEP_ORANGE: 'deep-orange',
  PURPLE: 'purple',
  methods: {
    showNotif (message, color = 'blue') {
      this.$q.notify({
        message: message,
        color: color
      })
    },
    showErrNotif (message) {
      this.$q.notify({
        message: 'Error! ' + message.error,
        color: 'red'
      })
    }
  }
}
