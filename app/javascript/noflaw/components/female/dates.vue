<template lang="pug">
  div(class="q-pa-md q-gutter-sm")
    q-badge(color="purple" text-color="white" class="q-ma-md") Mask: DD-MM-YYYY HH:mm
    div(class="q-gutter-md row items-start")
      q-date(v-model="dates" mask="DD-MM-YYYY HH:mm" multiple range color="purple" @input="onInput")
      q-time(v-model="dates" mask="DD-MM-YYYY HH:mm" color="purple")
    p(v-for="date in dates")
      q-badge(color="teal") {{ date }}
</template>

<script>
import notifications from 'notifications';
import {mapActions, mapState} from 'vuex'

export default {
  mixins: [notifications],
  name: "settings",
  data: function () {
    return {
      dates: ['08-02-2021 21:02']
    }
  },
  methods: {
    ...mapActions(['setMaleName']),
    onInput(value, reason, details){
      console.log(value)
      console.log(reason)
      console.log(details)
    }
  },
  computed: {
    ...mapState(['male_name'])
  }
}
</script>

<style scoped>

</style>