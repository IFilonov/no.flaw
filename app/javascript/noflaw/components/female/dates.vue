<template lang="pug">
  div(class="q-pa-md") Bad dates
    q-badge(color="purple" text-color="white" class="q-ma-md") Mask: DDMMYYYY
    div(class="q-gutter-md row items-start")
      q-date(v-model="dates" mask="DDMMYYYY" multiple today-btn first-day-of-week="1" range color="purple" @input="onInput")
      q-time(v-model="dates" mask="DD-MM-YYYY HH:mm" color="purple")
    div(class="q-pa-md")
      q-btn(class="glossy" label="Send" @click="sendDates" color="primary" :disable="disableSaveButton" v-close-popup icon="card_giftcard")
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
      dates: [],
      disableSaveButton: true
    }
  },
  methods: {
    ...mapActions(['setMaleName','setBadDates']),
    onInput(dates, reason, details){
      this.disableSaveButton = false;
      this.setBadDates(dates);
    },
    async sendDates() {
      let datesStr = JSON.stringify(this.dates.map(date => JSON.stringify(date)));
      await this.$api.female.setBadDates(datesStr);
    },
    async getBadDates() {
      return '';
    }
  },
  computed: {
    ...mapState(['male_name', 'bad_dates'])
  },
  mounted() {
    let bad_dates = '';
    bad_dates = this.getBadDates();
    if (bad_dates.length > 0) {
      this.setBadDates(JSON.parse(bad_dates).map(date => JSON.parse(date)));
    }
    this.dates = this.bad_dates
  }
}
</script>

<style scoped>

</style>