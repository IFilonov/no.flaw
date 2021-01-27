<template lang="pug">
  span(class="range")
    q-checkbox(keep-color v-model="saveTime" :label="date" color="deep-orange" text-color="deep-orange" style="align: left;")
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
        color="deep-orange")
</template>

<script>
export default {
  props: ['date'],
  data: function () {
    return {
      range: {
        min: 0,
        max: 24,
        step: 1
      },
      time: {
        min: 5,
        max: 7
      },
      saveTime: false,
      nextNum: 10
    }
  },
}
</script>

<style scoped>
.q-range {
  width: 400px;
  border: 3px solid;
}
.range {
  height: 64px;
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