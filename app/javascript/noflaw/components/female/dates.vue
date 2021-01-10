<template lang="pug">
  div(class="q-pa-md") Bad dates
    q-badge(color="purple" text-color="white" class="q-ma-md") Mask: DDMMYYYY
    div(class="q-gutter-md row items-start")
      q-date(v-model="dates" mask="DDMMYYYY" multiple today-btn first-day-of-week="1" range color="purple" @input="onInput")
      q-time(v-model="dates" mask="DD-MM-YYYY HH:mm" color="purple")
    div(class="q-pa-md")
      q-btn(glossy label="Send" @click="sendDates" color="purple" disable v-close-popup)
      p(v-for="date in dates")
        q-badge(color="teal") {{ JSON.stringify(date) }}
</template>

<script>
import notifications from 'notifications';
import {mapActions, mapState} from 'vuex'

export default {
  mixins: [notifications],
  name: "settings",
  data: function () {
    return {
      dates: []
    }
  },
  methods: {
    ...mapActions(['setMaleName','setBadDates']),
    onInput(dates, reason, details){
      let datesObj, datesStr;
      if(dates) {
        datesStr = dates.map(date => JSON.stringify(date));
        datesObj = datesStr.map(date => JSON.parse(date));
        this.setBadDates(datesStr);
        console.log(this.bad_dates)
        //console.log(datesStr)
        //console.log(datesObj)
      }
      // console.log(value)
      // console.log(reason)
      // console.log(details)
    },
    sendDates() {

    }
  },
  computed: {
    ...mapState(['male_name', 'bad_dates'])
  },
  mounted() {
    // this.getBadDates();
    this.dates = this.bad_dates.map(date => JSON.parse(date));
  }
}
</script>

<style scoped>

</style>