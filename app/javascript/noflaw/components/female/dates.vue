<template lang="pug">
  span(class="q-pa-md")
    span(class="q-pa-md q-gutter-sm")
      q-btn(push color="white" text-color="purple" class="text-bold" disable flat label="Taboo dates")
        q-badge(color="purple" floating) {{ taboo_dates ? taboo_dates.length : 0 }}
      div(class="q-gutter-md row items-start")
        q-date(v-model="taboo" :options="tabooOptionsFn" multiple today-btn first-day-of-week="1" color="purple" @input="onTabooChange")
      br
      q-btn(class="glossy" label="Send" @click="sendTabooDate" color="purple" :disable="disableSaveTaboo" v-close-popup icon="card_giftcard")
      q-btn(class="glossy" label="Clear" @click="clearTabooDate" color="purple" :disable="!Array.isArray(taboo)" v-close-popup icon="card_giftcard")
    span(class="q-gutter-sm")
      q-btn(push color="white" text-color="deep-orange" class="text-bold" disable flat label="Fire dates")
        q-badge(color="deep-orange" floating) {{ fire_dates ? fire_dates.length : 0 }}
      div(class="q-gutter-md row items-start")
        q-date(v-model="fire" :options="fireOptionsFn" multiple today-btn first-day-of-week="1" color="deep-orange" @input="onFireChange")
      br
      q-btn(class="glossy" label="Send" @click="sendFireDate" color="deep-orange" :disable="disableSaveFire" v-close-popup icon="card_giftcard")
      q-btn(class="glossy" label="Clear" @click="clearFireDate" color="deep-orange" :disable="!Array.isArray(fire)" v-close-popup icon="card_giftcard")
    span(class="q-pa-md" style="vertical-align: top;")
      div(v-for="(date) in fire")
        range(:date = "date")
</template>

<script>
import notifications from 'notifications';
import {mapActions, mapState} from 'vuex'
import range from './range'

export default {
  C_MAX_FIRE_DATES: 6,
  mixins: [notifications],
  name: "settings",
  components: {'range': range},
  data: function () {
    return {
      taboo: [],
      fire: [],
      times: [],
      currentDate: new Date(new Date().valueOf() - 86400000),
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
    async sendTabooDate() {
      let tabooDate = this.taboo_dates ? JSON.stringify(this.taboo_dates.map(date => JSON.stringify(date))) : null;
      const response = await this.$api.female.setTabooDate({ taboo_dates: tabooDate } );
      response.data.created_at ? this.showNotif(`Taboodates saved at ${response.data.created_at}`, 'purple')
          : this.showErrNotif(response.data.join());
    },
    async sendFireDate() {
      let fireDate = this.fire_dates ? JSON.stringify(this.fire_dates.map(date => JSON.stringify(date))) : null;
      const response = await this.$api.female.setFireDate({ fire_dates: fireDate } );
      response.data.created_at ? this.showNotif(`Firedates saved at ${response.data.created_at}`, 'deep-orange')
          : this.showErrNotif(response.data.join());
    },
    clearFireDate() {
      this.fire = null;
      this.disableSaveFire = false;
    },
    clearTabooDate() {
      this.taboo = null
      this.disableSaveTaboo = false;
    },
    fireOptionsFn(date) {
      return ((this.fire?.length > 5  || new Date(date) < this.currentDate)
          && !this.fire?.includes(date)) ? false : !this.taboo?.includes(date);
    },
    tabooOptionsFn(date) {
      return !this.fire?.includes(date);
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
    height: 200px;
  }
</style>