export default {
  data () {
    return {
      errors: []
    }
  },
  methods: {
    showNotif (message) {
      this.$q.notify({
        message: message,
        color: 'purple'
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
