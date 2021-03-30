<template lang="pug">
  div(class="q-pa-sm q-gutter-sm")
    fieldset(class="fieldset")
      legend issued:
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
              @dragstart.native="dragStart"
              draggable="true"
              :id="index"
              title="Drag to upper field to change") {{ task.name }}
    fieldset(class="fieldset")
      legend available:
      q-card(class="q-pa-md")
        q-option-group(v-model="group"
          :options="options"
          color="purple"
          inline
          type="toggle")
        div(class="row")
          q-intersection(v-for="(task, index) in tasks.available"
            :key="index"
            class="q-pa-sm"
            transition="scale")
            q-chip(removable
              class="glossy text-red text-bold"
              @remove=""
              color="light-grey"
              text-color="purple"
              icon="cake"
              @dragstart.native="availableDragStart"
              draggable="true"
              :id="index"
              title="Drag to upper field to change") {{ task.name }}
    fieldset(class="fieldset")
      legend executed:
      q-card(class="q-pa-md")
    fieldset(class="fieldset")
      legend added by me:
      q-card(class="q-pa-md")
</template>

<script>
import notifications from 'notifications';
import {mapActions, mapGetters} from 'vuex'

export default {
  mixins: [notifications],
  data: function () {
    return {
      group: ['op1'],
      options: [
        {
          label: 'Option 1',
          value: 'op1'
        },
        {
          label: 'Option 2',
          value: 'op2'
        },
        {
          label: 'Option 3',
          value: 'op3'
        }
      ]
    }
  },
  computed: {
    ...mapGetters(['tasks'])
  },
  mounted() {
    this.getTasks()
  },
  methods: {
    ...mapActions(['getTasks','setIssuedTask']),
    availableDragStart(ev) {
      ev.dataTransfer.effectAllowed = 'move'
      ev.dataTransfer.setData('available_id', ev.target.id)
    },
    issuedDropDragZone(ev) {
      this.setIssuedTask(this.tasks[ev.dataTransfer.getData('available_id')])
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
