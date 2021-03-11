<template lang="pug">
  div(class="q-pa-sm q-gutter-sm")
    q-card(class="q-pa-sm q-gutter-sm"
      @dragover.native="overDragZone"
      @drop.native="dropDragZone")
      q-btn(v-if="!getPair.username"
        class="glossy"
        no-caps
        color="blue"
        @click="$router.push({ name: 'PairNew'})"
        label="Add your pair")
      q-chip(v-if="getPair.username"
        title="One click to change or show"
        removable clickable
        @remove="$router.push({ name: 'PairDelete'})"
        @click="$router.push({ name: 'PairEdit' })"
        text-color="white"
        color="light-blue-8"
        class="glossy"
        size="lg")
        q-avatar(size="40px")
          img(:src="image(true)")
        span {{ getPair.nickname }}
    q-card(class="q-pa-sm q-gutter-sm" v-if="pairHistory.length > 0")
      q-intersection(v-for="(pair, index) in pairHistory"
        :key="index"
        transition="scale")
        q-chip(v-if="pair.username"
          title="One click to change or show"
          clickable
          draggable="true"
          :id="index"
          @dragstart.native="dragStart"
          text-color="white"
          color="light-blue-8"
          class="glossy"
          size="lg")
          q-avatar(size="40px")
            img(:src="image(true)")
          span {{ pair.nickname || pair.username }}
    router-view
</template>

<script>
import notifications from 'notifications';
import {mapActions, mapGetters} from 'vuex'

export default {
  mixins: [notifications],
  name: "settings",
  methods: {
    ...mapActions(['getPairHistory','setRecoverPair']),
    dragStart(ev) {
      ev.dataTransfer.effectAllowed = "move"
      ev.dataTransfer.setData('pair_id', ev.target.id)
    },
    dropDragZone(ev) {
      this.setRecoverPair(this.pairHistory[ev.dataTransfer.getData('pair_id')])
      this.$router.push({ name: this.getPair.username ? 'PairChange' : 'PairRevert' })
    },
    overDragZone(ev) {
      ev.preventDefault()
      ev.dataTransfer.dropEffect = "move"
    },
    skipDuplicatePageError(route) {
      if(this.$route.name !== route) {
        this.$router.replace({ name: route })
      }
    }
  },
  computed: {
    ...mapGetters(['getPair','pairHistory','image'])
  },
  mounted() {
    console.log(this.image())
    console.log(this.image(true))
    this.skipDuplicatePageError('Settings')
    this.getPairHistory()
  }
}
</script>
