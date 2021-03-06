<template lang="pug">
  div
    div(class="row q-pa-sm q-gutter-sm")
      div(class="q-pa-sm q-gutter-sm")
        q-btn(push color="white"
          text-color="purple"
          class="text-bold"
          disable flat
          label="Taboo dates")
          q-badge(color="purple" floating) {{ tabooDays ? tabooDays.length : 0 }}
        div(class="q-gutter-md row items-start")
          q-intersection(class="q-pa-sm my_trans"
            transition="scale")
            q-date(v-model="tabooDaysModel"
              :options="tabooOptionsFn"
              multiple today-btn
              first-day-of-week="1"
              color="purple"
              @input="onTabooChange")
        br
        q-btn(class="glossy"
          label="Save"
          @click="sendTabooDate"
          color="purple"
          :disable="disableSaveTaboo"
          v-close-popup
          icon="card_giftcard")
        q-btn(class="glossy"
          label="Clear"
          @click="clearTabooDate"
          color="purple"
          :disable="!Array.isArray(tabooDays)"
          v-close-popup
          icon="card_giftcard")
      div(class="q-pa-sm q-gutter-sm")
        q-btn(push color="white"
          text-color="deep-orange"
          class="text-bold"
          disable flat
          label="Fire dates")
          q-badge(color="deep-orange" floating) {{ fireDays ? fireDays.length : 0 }}
        div(class="q-gutter-md row items-start")
          q-intersection(class="q-pa-sm"
            transition="scale")
            q-date(v-model="fireDaysModel"
              :events="pairFireDays"
              event-color="lime"
              :options="fireOptionsFn"
              multiple today-btn
              first-day-of-week="1"
              color="deep-orange"
              @input="onFireChange")
        br
        q-btn(class="glossy"
          label="Save"
          @click="sendFireDate"
          color="deep-orange"
          :disable="disableSaveFire"
          v-close-popup
          icon="card_giftcard")
        q-btn(class="glossy"
          label="Clear"
          @click="clearFireDate"
          color="deep-orange"
          :disable="!Array.isArray(fireDays)"
          v-close-popup
          icon="card_giftcard")
      div(class="q-pa-sm")
        div(v-for="(fire_day) in fireDays")
          range(:fireDay = "fire_day" @onRangeChange="onRangeChange")
</template>

<script>
import notifications from 'notifications';
import {mapActions, mapGetters} from 'vuex'
import range from '../shared/range'

export default {
  C_MAX_FIRE_DATES: 6,
  name: 'Dates',
  components: {'range': range},
  mixins: [notifications],
  data: function () {
    return {
      currentDate: new Date(new Date().valueOf() - 86400000),
      disableSaveTaboo: true,
      disableSaveFire: true
    }
  },
  computed: {
    ...mapGetters(['pairFireDays','fireDays','tabooDays','fireDatesSer','tabooDatesSer']),
    fireDaysModel: {
      get: function() { return this.fireDays },
      set: function() {}
    },
    tabooDaysModel: {
      get: function() { return this.tabooDays },
      set: function() {}
    }
  },
  mounted() {
    this.getDates()
  },
  methods: {
    ...mapActions(['setTabooDates','getDates','setFireDays']),
    onTabooChange(taboo_days){
      this.disableSaveTaboo = false;
      this.setTabooDates(taboo_days);
    },
    onFireChange(fire_days){
      this.disableSaveFire = false;
      this.setFireDays(fire_days);
    },
    onRangeChange(){
      this.disableSaveFire = false;
    },
    async sendTabooDate() {
      const response = await this.$api.female.saveTabooDate({ taboo_date: this.tabooDatesSer } )
      this.disableSaveTaboo = true;
      console.log(response.data)
      response.data.error ? this.showErrNotif(response.data) :
        this.showNotif(`Taboodates saved at ${response.data.created_at}`, this.PURPLE)
    },
    async sendFireDate() {
      const response = await this.$api.female.saveFireDate({ fire_date: this.fireDatesSer } )
      this.disableSaveFire = true;
      response.data.error ? this.showErrNotif(response.data) :
        this.showNotif(`Firedates saved at ${response.data.created_at}`, this.DEEP_ORANGE)
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
  }
}
</script>

