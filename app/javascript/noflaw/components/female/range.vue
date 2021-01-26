<template lang="pug">
  div
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
export default {
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
      saveTime: false
    }
  }
}
</script>