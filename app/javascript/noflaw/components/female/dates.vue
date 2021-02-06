<template lang="pug">
  span(class="q-pa-md")
    span(class="q-pa-md q-gutter-sm")
      q-btn(push color="white" text-color="purple" class="text-bold" disable flat label="Taboo dates")
        q-badge(color="purple" floating) {{ taboo_dates ? taboo_dates.length : 0 }}
      div(class="q-gutter-md row items-start")
        q-date(v-model="taboo_dates" :options="tabooOptionsFn" multiple today-btn first-day-of-week="1" color="purple" @input="onTabooChange")
      br
      q-btn(class="glossy" label="Send" @click="sendTabooDate" color="purple" :disable="disableSaveTaboo" v-close-popup icon="card_giftcard")
      q-btn(class="glossy" label="Clear" @click="clearTabooDate" color="purple" :disable="!Array.isArray(taboo_dates)" v-close-popup icon="card_giftcard")
    span(class="q-gutter-sm")
      q-btn(push color="white" text-color="deep-orange" class="text-bold" disable flat label="Fire dates")
        q-badge(color="deep-orange" floating) {{ fire_dates ? fire_dates.length : 0 }}
      div(class="q-gutter-md row items-start")
        q-date(v-model="fire_dates" :options="fireOptionsFn" multiple today-btn first-day-of-week="1" color="deep-orange" @input="onFireChange")
      br
      q-btn(class="glossy" label="Send" @click="sendFireDate" color="deep-orange" :disable="disableSaveFire" v-close-popup icon="card_giftcard")
      q-btn(class="glossy" label="Clear" @click="clearFireDate" color="deep-orange" :disable="!Array.isArray(fire_dates)" v-close-popup icon="card_giftcard")
    span(class="q-pa-md" style="vertical-align: top;")
      div(v-for="(fire_date) in fire_dates")
        range(:fire_date = "fire_date")
</template>

<script>
import notifications from 'notifications';
import {mapActions, mapState, mapGetters} from 'vuex'
import range from './range'

export default {
  C_MAX_FIRE_DATES: 6,
  mixins: [notifications],
  name: "settings",
  components: {'range': range},
  data: function () {
    return {
      taboo_dates: [],
      fire_dates: [],
      times: [],
      currentDate: new Date(new Date().valueOf() - 86400000),
      disableSaveTaboo: true,
      disableSaveFire: true
    }
  },
  methods: {
    ...mapActions(['setMaleName','setTabooDate','dates','setFireDate']),
    onTabooChange(taboo_dates, reason, details){
      this.disableSaveTaboo = false;
      this.setTabooDate(taboo_dates);
    },
    onFireChange(fire_dates, reason, details){
      this.disableSaveFire = false;
      this.setFireDate(fire_dates);
    },
    async sendTabooDate() {
      let str_taboo_dates = this.taboo_dates ? JSON.stringify(this.taboo_dates.map(date => JSON.stringify(date))) : null;
      const response = await this.$api.female.setTabooDate({ taboo_dates: str_taboo_dates } );
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
      this.fire_dates = null;
      this.disableSaveFire = false;
    },
    clearTabooDate() {
      this.taboo_dates = null
      this.disableSaveTaboo = false;
    },
    fireOptionsFn(fire_date) {
      return ((this.fire_dates?.length > 5  || new Date(fire_date) < this.currentDate)
          && !this.fire_dates?.includes(fire_date)) ? false : !this.taboo_dates?.includes(fire_date);
    },
    tabooOptionsFn(taboo_date) {
      return ((new Date(taboo_date) < this.currentDate) && !this.taboo_dates?.includes(taboo_date))
          ? false : !this.fire_dates?.includes(taboo_date);

      //return !this.fire_dates?.includes(taboo_date);
    }
  },
  computed: {
    ...mapState(['male_name']),
    ...mapGetters(['fireDates','tabooDates'])
  },
  mounted() {
    this.dates();
    this.taboo_dates = this.tabooDates;
    this.fire_dates = this.fireDates;
  }
}
</script>

<style scoped>
  span {
    display: inline-block;
    height: 200px;
  }
</style>