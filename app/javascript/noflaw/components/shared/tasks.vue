<template lang="pug">
  div(class="q-pa-sm q-gutter-sm")
    q-card
      q-tabs(v-model="tab" align="left" dense class="text-grey-7 text-bold")
        q-route-tab(:label="'Manage ' +  getPair.username  + ' tasks'" :to="{ name: 'Tasks_manage' }")
        q-route-tab(label="My tasks execution" :to="{ name: 'Tasks_execute' }")
        q-route-tab(label="Generate new tasks" :to="{ name: 'Tasks_execute' }")
      q-card-section
        router-view
</template>

<script>
import {mapActions, mapGetters} from 'vuex'

export default {
  data: function () {
    return {
      tab: ''
    }
  },
  computed: {
    ...mapGetters(['tasks','categories','getPair'])
  },
  mounted() {
    this.getTasks()
  },
  methods: {
    ...mapActions(['getTasks','setIssuedTask'])
  }
}
</script>
