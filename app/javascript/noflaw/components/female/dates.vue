<template lang="pug">
  div(class="q-pa-md")
    span(class="q-pa-md")
      q-btn(push color="white" text-color="purple" class="text-bold" disable flat label="Taboo dates")
        q-badge(color="purple" floating) {{ taboo_dates ? taboo_dates.length : 0 }}
      div(class="q-gutter-md row items-start")
        q-date(v-model="taboo" :options="tabooOptionsFn" multiple today-btn first-day-of-week="1" color="purple" @input="onTabooChange")
      br
      q-btn(class="glossy" label="Send" @click="sendTabooDate" color="purple" :disable="disableSaveTaboo" v-close-popup icon="card_giftcard")
    span(class="q-pa-md")
      q-btn(push color="white" text-color="deep-orange" class="text-bold" disable flat label="Fire dates")
        q-badge(color="deep-orange" floating) {{ fire_dates ? fire_dates.length : 0 }}
      div(class="q-gutter-md row items-start")
        q-date(v-model="fire" :options="fireOptionsFn" multiple today-btn first-day-of-week="1" color="deep-orange" @input="onFireChange")
      br
      q-btn(class="glossy" label="Send" @click="sendFireDate" color="deep-orange" :disable="disableSaveFire" v-close-popup icon="card_giftcard")
    span(class="q-pa-md" style="vertical-align: top;")
      range
      range
      range
      q-btn(push color="white" text-color="deep-orange" class="text-bold" disable flat label="Fire time")
      div(class="q-gutter-sm")
        q-checkbox(keep-color v-model="saveTime" label="Time" color="deep-orange")
      q-range(v-model="time"
        class="q-range"
        left-label-color="deep-orange"
        right-label-color="deep-orange"
        :left-label-value="time.min + 'h'"
        :right-label-value="time.max + 'h'"
        :min="range.min"
        :max="range.max"
        :step="range.step"
        label-always
        vertical
        markers
        :disable="!saveTime"
        drag-range
        color="deep-orange")
</template>

<script>
import notifications from 'notifications';
import {mapActions, mapState} from 'vuex'
import range from './range'

export default {
  mixins: [notifications],
  name: "settings",
  components: {'range': range},
  data: function () {
    return {
      taboo: [],
      fire: [],
      times: [],
      disableSaveTaboo: true,
      disableSaveFire: true,
      range: {
        min: 0,
        max: 24,
        step: 1
      },
      time: {
        min: 5,
        max: 7
      },
      saveTime: false
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
      console.log(this.time);
      this.setFireDate(dates);
    },
    async sendTabooDate() {
      console.log(this.taboo);
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
    },
    fireOptionsFn(date) {
      return !this.taboo?.includes(date);
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
  .q-range {
    height: 338px;
    background-size: 100% 2px, 100% 2px, var(--tick-bg-size);
    border: 4px solid;
  }
</style>