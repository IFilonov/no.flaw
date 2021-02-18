<template lang="pug">
  div
    div(class="row q-pa-sm q-gutter-sm")
      div(class="q-pa-sm q-gutter-sm")
        q-btn(push color="white" text-color="purple" class="text-bold" disable flat label="Taboo dates")
          q-badge(color="purple" floating) {{ tabooDays ? tabooDays.length : 0 }}
        div(class="q-gutter-md row items-start")
          q-date(v-model="tabooDaysModel" :options="tabooOptionsFn" multiple today-btn first-day-of-week="1" color="purple" @input="onTabooChange")
        br
        q-btn(class="glossy" label="Save" @click="sendTabooDate" color="purple" :disable="disableSaveTaboo" v-close-popup icon="card_giftcard")
        q-btn(class="glossy" label="Clear" @click="clearTabooDate" color="purple" :disable="!Array.isArray(tabooDays)" v-close-popup icon="card_giftcard")
      div(class="q-pa-sm q-gutter-sm")
        q-btn(push color="white" text-color="deep-orange" class="text-bold" disable flat label="Fire dates")
          q-badge(color="deep-orange" floating) {{ fireDays ? fireDays.length : 0 }}
        div(class="q-gutter-md row items-start")
          q-date(v-model="fireDaysModel" :options="fireOptionsFn" multiple today-btn first-day-of-week="1" color="deep-orange" @input="onFireChange")
        br
        q-btn(class="glossy" label="Save" @click="sendFireDate" color="deep-orange" :disable="disableSaveFire" v-close-popup icon="card_giftcard")
        q-btn(class="glossy" label="Clear" @click="clearFireDate" color="deep-orange" :disable="!Array.isArray(fireDays)" v-close-popup icon="card_giftcard")
      div(class="q-pa-sm")
        div(v-for="(fire_day) in fireDays")
          range(:fire_day = "fire_day" @onRangeChange="onRangeChange")
</template>

<script>
import notifications from 'notifications';
import {mapActions, mapState, mapGetters} from 'vuex'
import range from './range'

export default {
  C_MAX_FIRE_DATES: 6,
  mixins: [notifications],
  name: "dates",
  components: {'range': range},
  data: function () {
    return {
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
      this.setFireDays([]);
      this.disableSaveFire = false;
    },
    clearTabooDate() {
      this.setTabooDates([]);
      this.disableSaveTaboo = false;
    },
    fireOptionsFn(fire_date) {
      return ((this.fireDays?.length > 5  || new Date(fire_date) < this.currentDate)
          && !this.fireDays?.includes(fire_date)) ? false : !this.tabooDays?.includes(fire_date);
    },
    tabooOptionsFn(taboo_date) {
      return ((new Date(taboo_date) < this.currentDate) && !this.tabooDays?.includes(taboo_date))
          ? false : !this.fireDays?.includes(taboo_date);
    }
  },
  computed: {
    ...mapState(['male_name']),
    ...mapGetters(['fireDays','tabooDays','fireDatesSer','tabooDatesSer']),
    fireDaysModel: {
      get: function() { return this.fireDays },
      set: function(newValue) {}
    },
    tabooDaysModel: {
      get: function() { return this.tabooDays },
      set: function(newValue) {}
    }
  },
  mounted() {
    this.getDates()
  }
}
</script>
