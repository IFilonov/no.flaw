<template lang="pug">
  span(class="range")
    q-checkbox(keep-color v-model="checkTime" :label="fire_day" color="deep-orange"
      @input="onCheckbox" text-color="deep-orange" style="align: left;")
      q-range(v-model="time"
        :style="trackStyle"
        class="custom-colored-range q-range custom-colored-range--inside"
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
        min: 18,
        max: 22
      },
      cross_time: {},
      checkTime: false,
      nextNum: 10,
      zones: [
        { color: 'teal', min: 0, max: 6 },
        { color: 'lime', min: 6, max: 15 },
        { color: 'teal', min: 15, max: 24 }
      ]
    }
  },
  methods: {
    ...mapActions(['setFireTime']),
    onRangeChange(value) {
      this.setFireTime({ day: this.fire_day, time: value })
      this.$emit('onRangeChange')
    },
    onCheckbox(checked) {
      this.onRangeChange(checked ? this.time : {} )
      this.$emit('onRangeChange')
    }
  },
  computed: {
    ...mapGetters(['fireDayTime']),
    trackStyle () {
      const colors = []
      const { min, max } = this.range
      const range = max - min

      let prev = min

      for (let i = 0; i < this.zones.length; i++) {
        const zone = this.zones[i]

        if (zone.min > prev) {
          colors.push(`transparent ${(prev - min) / range * 100}%`)
          colors.push(`transparent ${(zone.min - min) / range * 100}%`)
        }

        colors.push(`${zone.color} ${(zone.min - min) / range * 100}%`)
        colors.push(`${zone.color} ${(zone.max - min) / range * 100}%`)

        prev = zone.max
      }

      if (prev < max) {
        colors.push(`transparent ${(prev - min) / range * 100}%`)
        colors.push(`transparent ${(max - min) / range * 100}%`)
      }

      return {
        '--track-bg': `linear-gradient(to right,${colors.join(',')})`
      }
    }
  },
  mounted() {
    let time = this.fireDayTime(this.fire_day)
    this.checkTime = Object.keys(time).length > 0
    this.time = this.checkTime ? time : this.time
  }
}
</script>

<style lang="stylus">
.q-range
  width: 400px
//  border: 6px solid
//  height: 6px
.range
  height: 56px
.custom-colored-range
  .q-slider__track-container--h
    background-image: var(--track-bg)
    margin-top: -3px
    height: 10px
.custom-colored-range--inside
  .q-slider__track--h
    top: 3px
    bottom: 3px
</style>