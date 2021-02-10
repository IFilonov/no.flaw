<template lang="pug">
  span(class="range")
    q-checkbox(keep-color v-model="checkTime" :label="fire_day" color="deep-orange"
      @input="onCheckbox" text-color="deep-orange" style="align: left;")
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
        :disable="!checkTime"
        drag-range
        @change="onRangeChange"
        color="deep-orange")
</template>

<script>
import {mapActions, mapGetters, mapState} from 'vuex'
export default {
  props: ['fire_day'],
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
      checkTime: false,
      nextNum: 10
    }
  },
  methods: {
    ...mapActions(['setFireTime']),
    onRangeChange(value) {
      this.setFireTime({ day: this.fire_day, time: value })
    },
    onCheckbox(value) {
      this.onRangeChange(value ? this.time : null )
    }
  },
  computed: {
    ...mapGetters(['fireDayTime'])
  },
  mounted() {
    let time = this.fireDayTime(this.fire_day)
    this.time = !!time.min ? time : this.time
    this.checkTime = !!time.min
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