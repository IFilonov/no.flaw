export default {
  data () {
    return {
      errors: []
    }
  },
  methods: {
    showNotif (message, color) {
      this.$q.notify({
        message: message,
        color: color
      })
    },
    showErrNotif (message) {
      this.$q.notify({
        message: 'Error! ' + message,
        color: 'red'
      })
    }
  }
}
