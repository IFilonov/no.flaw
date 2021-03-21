<template lang="pug">
  span(class="range")
    q-checkbox(keep-color v-model="checkTime" :label="fireDay" color="deep-orange"
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
        color="purple")
</template>

<script>
const C_DEEP_ORANGE = '#FF5722';
const C_LIME = 'orange';
import {mapActions, mapGetters} from 'vuex'
export default {
  props: {
    fireDay: {
      type: String,
      required: false,
      default: null
    }
  },
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
      pair_time: {},
      checkTime: false,
      nextNum: 10,
      zones: [
        { color: C_DEEP_ORANGE, min: 0, max: 6 },
        { color: C_DEEP_ORANGE, min: 6, max: 15 },
        { color: C_DEEP_ORANGE, min: 15, max: 24 }
      ]
    }
  },
  computed: {
    ...mapGetters(['fireDayTime','pairFireDayTime']),
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
    this.fillData();
  },
  methods: {
    ...mapActions(['setFireTime']),
    onRangeChange(value) {
      this.setFireTime({ day: this.fireDay, time: value })
      this.$emit('onRangeChange')
    },
    onCheckbox(checked) {
      this.onRangeChange(checked ? this.time : {} )
      this.$emit('onRangeChange')
    },
    fillData(){
      let time = this.fireDayTime(this.fireDay)
      this.pair_time = this.pairFireDayTime(this.fireDay)
      if(this.pair_time) {
        this.zones[0].max = this.zones[1].min = this.pair_time.min
        this.zones[1].max = this.zones[2].min = this.pair_time.max
        this.zones[1].color = C_LIME
      }
      this.checkTime = Object.keys(time).length > 0
      this.time = this.checkTime ? time : this.time
    }
  }
}
</script>

<style lang="stylus">
.q-range
  width: 400px
.range
  height: 56px
.custom-colored-range
  .q-slider__track-container--h
    background-image: var(--track-bg)
    height: 10px
    box-shadow: 4px 4px 3px #BBBBBB
.custom-colored-range--inside
  .q-slider__track--h
    top: 4px
    bottom: 4px
  .q-slider__track-markers
    color: purple
</style>