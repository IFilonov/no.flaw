<template lang="pug">
  div(class="q-pa-md")
    span(class="q-pa-md")
      q-btn(push color="white" text-color="purple" class="text-bold" disable flat label="Taboo dates")
        q-badge(color="purple" floating) {{ taboo_dates ? taboo_dates.length : 0 }}
      div(class="q-gutter-md row items-start")
        q-date(v-model="taboo" mask="DDMMYYYY" multiple today-btn first-day-of-week="1" range color="purple" @input="onTabooChange")
      br
      q-btn(class="glossy" label="Send" @click="sendTabooDate" color="purple" :disable="disableSaveTaboo" v-close-popup icon="card_giftcard")
    span(class="q-pa-md")
      q-btn(push color="white" text-color="deep-orange" class="text-bold" disable flat label="Fire dates")
        q-badge(color="deep-orange" floating) {{ fire_dates ? fire_dates.length : 0 }}
      div(class="q-gutter-md row items-start")
        q-date(v-model="fire" mask="DDMMYYYY" multiple today-btn first-day-of-week="1" range color="deep-orange" @input="onFireChange")
        q-time(v-model="times" mask="DD-MM-YYYY HH:mm" color="deep-orange" @input="onTimeChange")
      br
      q-btn(class="glossy" label="Send" @click="sendFireDate" color="deep-orange" :disable="disableSaveFire" v-close-popup icon="card_giftcard")
</template>

<script>
import notifications from 'notifications';
import {mapActions, mapState} from 'vuex'

export default {
  mixins: [notifications],
  name: "settings",
  data: function () {
    return {
      taboo: [],
      fire: [],
      times: [],
      disableSaveTaboo: true,
      disableSaveFire: true
    }
  },
  methods: {
    ...mapActions(['setMaleName','setTabooDate','dates','setFireDate']),
    onTabooChange(dates, reason, details){
      this.disableSaveTaboo = false;
      this.setTabooDate(dates);
    },
    onFireChange(dates, reason, details){
      this.disableSaveFire = false;
      this.setFireDate(dates);
    },
    onTimeChange(times, reason, details){
      console.log(times);
    },
    async sendTabooDate() {
      let tabooDate = this.taboo_dates ? JSON.stringify(this.taboo_dates.map(date => JSON.stringify(date))) : null;
      const response = await this.$api.female.setTabooDate({ taboo_dates: tabooDate } );
      response.data.created_at ? this.showNotif(`Taboodates saved at ${response.data.created_at}`)
          : this.showErrNotif(response.data[0]);
    },
    async sendFireDate() {
      let fireDate = this.fire_dates ? JSON.stringify(this.fire_dates.map(date => JSON.stringify(date))) : null;
      const response = await this.$api.female.setFireDate({ fire_dates: fireDate } );
      response.data.created_at ? this.showNotif(`Firedates saved at ${response.data.created_at}`)
          : this.showErrNotif(response.data[0]);
    }
  },
  computed: {
    ...mapState(['male_name', 'taboo_dates', 'fire_dates'])
  },
  mounted() {
    this.dates();
    this.taboo = this.taboo_dates;
    this.fire = this.fire_dates;
  }
}
</script>

<style scoped>
  span {
    display: inline-block;
  }
</style>