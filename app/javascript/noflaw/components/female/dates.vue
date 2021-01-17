<template lang="pug">
  div(class="q-pa-md")
    q-btn(push color="white" text-color="purple" class="text-bold" disable flat label="Taboo dates")
      q-badge(color="purple" floating) {{ taboo_dates.length }}
    div(class="q-gutter-md row items-start")
      q-date(v-model="dates" mask="DDMMYYYY" multiple today-btn first-day-of-week="1" range color="purple" @input="onDateChange")
      q-time(v-model="times" mask="DD-MM-YYYY HH:mm" color="purple" @input="onTimeChange")
    br
    q-btn(class="glossy" label="Send" @click="sendTabooDate" color="purple" :disable="disableSaveButton" v-close-popup icon="card_giftcard")
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
      times: [],
      disableSaveButton: true
    }
  },
  methods: {
    ...mapActions(['setMaleName','setTabooDates','tabooDates']),
    onDateChange(dates, reason, details){
      this.disableSaveButton = false;
      this.setTabooDates(dates);
    },
    onTimeChange(times, reason, details){
      console.log(times);
    },
    async sendTabooDate() {
      let tabooDate = JSON.stringify(this.taboo_dates.map(date => JSON.stringify(date)));
      await this.$api.female.setTabooDates({ taboo_dates: tabooDate } );
    }
  },
  computed: {
    ...mapState(['male_name', 'taboo_dates'])
  },
  mounted() {
    this.tabooDates();
    this.dates = this.taboo_dates;
  }
}
</script>

<style scoped>

</style>