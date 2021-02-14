<template lang="pug">
  div
    div(class="row q-pa-sm q-gutter-sm")
      div(class="q-pa-sm q-gutter-sm")
        q-btn(push color="white" text-color="purple" class="text-bold" disable flat label="Taboo dates")
          q-badge(color="purple" floating) {{ taboo_days ? taboo_days.length : 0 }}
        div
          q-date(v-model="taboo_days" :options="tabooOptionsFn" disable multiple today-btn first-day-of-week="1" color="purple" @input="onTabooChange")
      div(class="q-pa-sm q-gutter-sm")
        q-btn(push color="white" text-color="deep-orange" class="text-bold" disable flat label="Fire dates")
          q-badge(color="deep-orange" floating) {{ fire_days ? fire_days.length : 0 }}
        div
          q-date(v-model="fire_days" :options="fireOptionsFn" multiple today-btn first-day-of-week="1" color="deep-orange" @input="onFireChange")
          div(class="q-pa-md q-gutter-sm")
            q-btn(class="glossy" label="Save" @click="sendFireDate" color="deep-orange" :disable="disableSaveFire" v-close-popup icon="card_giftcard")
            q-btn(class="glossy" label="Clear" @click="clearFireDate" color="deep-orange" :disable="!Array.isArray(fire_days)" v-close-popup icon="card_giftcard")
</template>

<script>
import notifications from 'notifications';
import {mapActions, mapState, mapGetters} from 'vuex'

export default {
  C_MAX_FIRE_DATES: 6,
  mixins: [notifications],
  name: "settings",
  data: function () {
    return {
      taboo_days: [],
      fire_days: [],
      times: [],
      currentDate: new Date(new Date().valueOf() - 86400000),
      disableSaveTaboo: true,
      disableSaveFire: true
    }
  },
  methods: {
    ...mapActions(['setMaleName','setTabooDates','getDates','setFireDays']),
    onTabooChange(taboo_days, reason, details){
      this.disableSaveTaboo = false;
      this.setTabooDates(taboo_days);
    },
    onFireChange(fire_days, reason, details){
      this.disableSaveFire = false;
      this.setFireDays(fire_days);
    },
    onRangeChange(){
      this.disableSaveFire = false;
    },
    async sendTabooDate() {
      const response = await this.$api.female.saveTabooDate({ taboo_dates: this.tabooDatesSer } );
      this.disableSaveTaboo = true;
      response.data.created_at ? this.showNotif(`Taboodates saved at ${response.data.created_at}`, 'purple')
          : this.showErrNotif(response.data.join());
    },
    async sendFireDate() {
      const response = await this.$api.female.saveFireDate({ fire_dates: this.fireDatesSer } );
      this.disableSaveFire = true;
      response.data.created_at ? this.showNotif(`Firedates saved at ${response.data.created_at}`, 'deep-orange')
          : this.showErrNotif(response.data.join());
    },
    clearFireDate() {
      this.fire_days = []
      this.setFireDays(this.fire_days);
      this.disableSaveFire = false;
    },
    clearTabooDate() {
      this.taboo_days = []
      this.setTabooDates(this.taboo_days);
      this.disableSaveTaboo = false;
    },
    fireOptionsFn(fire_date) {
      return ((this.fire_days?.length > 5  || new Date(fire_date) < this.currentDate)
          && !this.fire_days?.includes(fire_date)) ? false : !this.taboo_days?.includes(fire_date);
    },
    tabooOptionsFn(taboo_date) {
      return ((new Date(taboo_date) < this.currentDate) && !this.taboo_days?.includes(taboo_date))
          ? false : !this.fire_days?.includes(taboo_date);
    }
  },
  computed: {
    ...mapState(['male_name']),
    ...mapGetters(['fireDays','tabooDays','fireDatesSer','tabooDatesSer'])
  },
  mounted() {
    this.getDates()
    console.log(this.tabooDays)
    console.log(this.fireDays)
    this.taboo_days = this.tabooDays
    //this.fire_days = this.fireDays
  }
}
</script>

<style scoped>
  span {
    display: inline-block;
    height: 200px;
  }
</style>