<template lang="pug">
  div
    fieldset(class="fieldset")
      legend executed:
      q-card(class="q-pa-md")
    fieldset(class="fieldset")
      legend added by me:
      q-card(class="q-pa-md")
</template>

<script>
import notifications from 'notifications'
import {mapActions, mapGetters} from 'vuex'

export default {
  mixins: [notifications],
  data: function () {
    return {
      category: [],
      tab: ''
    }
  },
  computed: {
    ...mapGetters(['tasks','categories'])
  },
  mounted() {
    this.getTasks()
    this.category = this.categories.map(category => category.value)
  },
  methods: {
    ...mapActions(['getTasks','setIssuedTask']),
    availableDragStart(ev) {
      ev.dataTransfer.effectAllowed = 'move'
      ev.dataTransfer.setData('available_id', ev.target.id)
    },
    issuedDropDragZone(ev) {
      console.log(this.tasks.available[ev.dataTransfer.getData('available_id')])
      this.setIssuedTask(this.tasks.available[ev.dataTransfer.getData('available_id')])
    },
    issuedOverDragZone(ev) {
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
