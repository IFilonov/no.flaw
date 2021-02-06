<template lang="pug">
  span(class="range")
    q-checkbox(keep-color v-model="saveTime" :label="fire_date" color="deep-orange"
      new_fire_times @input="onCheckbox" text-color="deep-orange" style="align: left;")
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
        markers
        :disable="!saveTime"
        drag-range
        @change="onRangeChange"
        color="deep-orange")
</template>

<script>
import {mapActions, mapState} from 'vuex'
export default {
  props: ['fire_date','fire_date_index'],
  data: function () {
    return {
      range: {
        min: 0,
        max: 24,
        step: 1
      },
      time: {
        min: 20,
        max: 22
      },
      saveTime: false,
      nextNum: 10
    }
  },
  methods: {
    ...mapActions(['setFireTimes']),
    onRangeChange(value) {
      this.setFireTimes({ date: this.fire_date, time: value })
    },
    onCheckbox(value) {
      this.setFireTimes({ date: this.fire_date, time: value ? this.time : null })
    }
  },
  computed: {
    ...mapState(['fire_times'])
  },
  mounted() {
    if(this.fire_times.length > 0) {
      //this.time = this.fire_times.find(fire_time => fire_time.date === this.fire_date);
      console.log(this.time)
    }
  }
}
</script>

<style scoped>
.q-range {
  width: 400px;
  border: 3px solid;
  height: 30px;
}
.range {
  height: 56px;
}
.list-item {
  display: inline-block;
  margin-right: 10px;
}
.list-enter-active, .list-leave-active {
  transition: all 1s;
}
.list-enter, .list-leave-to /* .list-leave-active below version 2.1.8 */ {
  opacity: 0;
  transform: translateY(30px);
}
</style>