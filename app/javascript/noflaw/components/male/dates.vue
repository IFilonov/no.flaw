<template lang="pug">
  div
    div(class="row q-pa-sm q-gutter-sm")
      div(class="q-pa-sm q-gutter-sm")
        q-btn(push color="white"
          text-color="purple"
          class="text-bold"
          disable flat
          label="Female taboo dates")
          q-badge(color="purple" floating) {{ tabooDaysModel ? tabooDaysModel.length : 0 }}
        div
          q-date(v-model="tabooDaysModel"
            multiple today-btn
            first-day-of-week="1"
            color="purple")
      div(class="q-pa-sm q-gutter-sm")
        q-btn(color="white"
          text-color="deep-orange"
          class="text-bold"
          disable flat push
          label="Fire dates")
          q-badge(color="deep-orange" floating) {{ fire_days ? fire_days.length : 0 }}
        div
          q-date(v-model="fireDaysModel"
            :events="femaleFireDays"
            event-color="lime"
            :options="fireOptionsFn"
            multiple today-btn
            first-day-of-week="1"
            color="deep-orange"
            @input="onFireChange")
          div(class="q-pa-md q-gutter-sm")
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
              :disable="!Array.isArray(fire_days)"
              v-close-popup
              icon="card_giftcard")
      div(class="q-pa-sm")
        div(v-for="(fire_day) in fireDays")
          range(:fire_day = "fire_day" @onRangeChange="onRangeChange")
</template>

<script>
import notifications from 'notifications';
import {mapActions, mapState, mapGetters} from 'vuex'
import range from '../shared/range'

export default {
  C_MAX_FIRE_DATES: 6,
  mixins: [notifications],
  name: "dates",
  components: {'range': range},
  data: function () {
    return {
      fire_days: [],
      times: [],
      currentDate: new Date(new Date().valueOf() - 86400000),
      disableSaveTaboo: true,
      disableSaveFire: true
    }
  },
  methods: {
    ...mapActions(['setMaleName','setTabooDates','getDates','setFireDays']),
    onFireChange(fire_days, reason, details){
      this.disableSaveFire = false;
      this.setFireDays(fire_days);
    },
    onRangeChange(){
      this.disableSaveFire = false;
    },
    async sendFireDate() {
      const response = await this.$api.male.saveFireDate({ fire_dates: this.fireDatesSer } );
      this.disableSaveFire = true;
      response.data.created_at ? this.showNotif(`Firedates saved at ${response.data.created_at}`, 'deep-orange')
          : this.showErrNotif(response.data.join());
    },
    clearFireDate() {
      this.setFireDays([]);
      this.disableSaveFire = false;
    },
    fireOptionsFn(fire_date) {
      return ((this.fire_days?.length > 5  || new Date(fire_date) < this.currentDate)
          && !this.fire_days?.includes(fire_date)) ? false : !this.tabooDays?.includes(fire_date);
    }
  },
  computed: {
    ...mapState(['male_name']),
    ...mapGetters(['femaleFireDays','tabooDays','fireDays','fireDatesSer','tabooDatesSer']),
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
