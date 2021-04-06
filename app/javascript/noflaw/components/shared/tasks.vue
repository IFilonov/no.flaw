<template lang="pug">
  div(class="q-pa-sm q-gutter-sm")
    fieldset(class="fieldset")
      legend issued:
      q-card(class="q-pa-md"
        @dragover.native="issuedOverDragZone"
        @drop.native="issuedDropDragZone")
        div(class="row")
          q-intersection(v-for="(task, index) in local_tasks.issued"
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
              title="Issue task") {{ task.name }}
    fieldset(class="fieldset")
      legend available:
      q-card(class="q-pa-md")
        q-option-group(v-model="category"
          :options="categories"
          color="purple"
          inline
          @input="onChangeCategory"
          type="toggle")
        div(class="row")
          q-intersection(v-for="(task, index) in local_tasks.available"
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
      local_tasks: []
    }
  },
  computed: {
    ...mapGetters(['tasks','categories'])
  },
  mounted() {
    this.getTasks()
    this.local_tasks = this.tasks
    this.category = this.categories.map(category => category.value)
  },
  methods: {
    ...mapActions(['getTasks','setIssuedTask']),
    onChangeCategory(value){
      this.local_tasks.available = this.tasks.available.filter(task => value.includes(task.category_id) )
    },
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
