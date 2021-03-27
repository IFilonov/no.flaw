<template lang="pug">
  div(class="q-pa-sm q-gutter-sm")
    fieldset(class="fieldset")
      legend issued:
      q-card(class="q-pa-md")
    fieldset(class="fieldset")
      legend available:
      q-card(class="q-pa-md")
        div(class="row")
          q-intersection(v-for="(task, index) in tasks.available"
            :key="index"
            class="q-pa-sm"
            transition="scale")
            q-chip(removable
              class="glossy text-red text-bold"
              @remove=""
              color="blue"
              text-color="white"
              icon="cake"
              @dragstart.native="dragStart"
              draggable="true"
              :id="index"
              title="Drag to upper field to change") {{ task.name }}
    fieldset(class="fieldset")
      legend executed:
      q-card(class="q-pa-md")
</template>

<script>
import notifications from 'notifications';
import {mapActions, mapGetters} from 'vuex'

export default {
  mixins: [notifications],
  computed: {
    ...mapGetters(['tasks'])
  },
  mounted() {
    this.getTasks()
  },
  methods: {
    ...mapActions(['getTasks']),
    dragStart(ev) {
      ev.dataTransfer.effectAllowed = 'move'
      ev.dataTransfer.setData('pair_id', ev.target.id)
    },
    dropDragZone(ev) {
      this.setRecoverPair(this.pairHistory[ev.dataTransfer.getData('pair_id')])
      this.$router.push({ name: this.getPair.username ? 'PairChange' : 'PairRevert' })
    },
    overDragZone(ev) {
      ev.preventDefault()
      ev.dataTransfer.dropEffect = 'move'
    }
  }
}
</script>

<style lang="stylus" scoped>
.fieldset
  border-style hidden
</style>
