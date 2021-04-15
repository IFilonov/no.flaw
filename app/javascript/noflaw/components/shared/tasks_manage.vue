<template lang="pug">
  div
    fieldset(class="fieldset")
      legend(class="text-grey-7 text-bold") in the {{  getPair.username }} execution queue:
      q-card(class="q-pa-md"
        @dragover.native="issuedOverDragZone"
        @drop.native="issuedDropDragZone")
        div(class="row")
          q-intersection(v-for="(task, index) in tasks.issued"
            :key="index"
            class="q-pa-sm"
            transition="scale")
            q-chip(removable
            class="glossy text-red text-bold"
              @remove=""
              color="light-grey"
              text-color="blue"
              icon="cake"
              :id="index"
              title="Issue task") {{ task.gender_task.name }} up to {{ task.planned_time }}
    fieldset(class="fieldset")
      legend(class="text-grey-7 text-bold") available for {{  getPair.username }}. Throw it up
      q-card(class="q-pa-md")
        q-option-group(v-model="category"
          :options="categories"
          color="purple"
          inline)
        div(class="row")
          q-intersection(v-for="(task, index) in tasks.available.filter(task => category == task.category_id)"
            :key="index"
            class="q-pa-sm"
            transition="scale")
            q-chip(class="glossy text-red text-bold"
              @remove=""
              color="light-grey"
              text-color="purple"
              icon="cake"
              @dragstart.native="availableDragStart"
              draggable="true"
              :id="index"
              title="Drag to upper field to change") {{ task.name }}
</template>

<script>
import notifications from 'notifications'
import {mapActions, mapGetters} from 'vuex'

export default {
  mixins: [notifications],
  data: function () {
    return {
      category: '',
      tab: ''
    }
  },
  computed: {
    ...mapGetters(['tasks','categories','getPair'])
  },
  mounted() {
    this.getTasks()
    this.category = this.categories[0].value
  },
  methods: {
    ...mapActions(['getTasks','setIssuedTask']),
    availableDragStart(ev) {
      ev.dataTransfer.effectAllowed = 'move'
      ev.dataTransfer.setData('available_id', ev.target.id)
    },
    issuedDropDragZone(ev) {
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
