<template lang="pug">
  div(class="q-pa-sm q-gutter-sm")
    fieldset(class="fieldset_class")
      legend issued:
      q-card(class="q-pa-md")
    fieldset(class="fieldset_class")
      legend available:
      q-card(class="q-pa-md"
        @dragover.native="overDragZone"
        @drop.native="dropDragZone")
    fieldset(class="fieldset_class")
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
    console.log(this.tasks)
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
.fieldset_class
  border-style hidden
</style>
