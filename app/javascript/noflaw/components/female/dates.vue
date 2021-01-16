<template lang="pug">
  div(class="q-pa-md") Bad dates
    q-badge(color="purple" text-color="white" class="q-ma-md") Mask: DDMMYYYY
    div(class="q-gutter-md row items-start")
      q-date(v-model="dates" mask="DDMMYYYY" multiple today-btn first-day-of-week="1" range color="purple" @input="onInput")
      q-time(v-model="dates" mask="DD-MM-YYYY HH:mm" color="purple")
    div(class="q-pa-md")
      q-btn(class="glossy" label="Send" @click="sendTabooDate" color="primary" :disable="disableSaveButton" v-close-popup icon="card_giftcard")
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
    ...mapActions(['setMaleName','setTabooDates','tabooDates']),
    onInput(dates, reason, details){
      this.disableSaveButton = false;
      this.setTabooDates(dates);
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