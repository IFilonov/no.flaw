<template lang="pug">
  div(class="q-pa-sm q-gutter-sm")
    q-card(class="q-pa-md q-gutter-sm"
      @dragover.native="overDragZone"
      @drop.native="dropDragZone")
      q-btn(v-if="!getPair.username"
        class="glossy text-light-blue-9 text-bold"
        no-caps
        icon="fas fa-user-plus"
        @click="$router.push({ name: 'PairNew'})"
        label="add pair")
      q-card(v-if="getPair.username"
        class="q-pa-sm q-gutter-sm"
        title="One click to change or show"
        removable clickable
        @remove="$router.push({ name: 'PairDelete'})"
        @click="$router.push({ name: 'PairEdit' })")
        q-item
          q-item-section(avatar)
            q-avatar(size="60px")
              img(:src="image(true)" draggable="false")
          q-item-section
            q-item-label name: {{ getPair.username }}
            q-item-label(caption) nick: {{ getPair.nickname }}
            q-item-label joined: {{ getPair.pair_created_at }}
          q-item-section(avatar class="text-light-blue-9")
            q-btn(round icon="fas fa-user-minus"
              @click="$router.push({ name: 'PairDelete'})"
              title="Delete pair")
    q-card(class="q-pa-sm q-gutter-sm" v-if="pairHistory.length > 0")
      div(class="row")
        q-intersection(v-for="(pair, index) in pairHistory"
          :key="index"
          class="my-card q-pa-sm"
          transition="scale")
          q-card(draggable="true"
            color="light-blue-8"
            :id="index"
            title="Drag to upper field to change"
            @dragstart.native="dragStart")
            q-item
              q-item-section(avatar)
                q-avatar(size="40px")
                  img(:src="image(true)" draggable="false")
              q-item-section
                q-item-label {{ pair.username }}
                q-item-label(caption) nick: {{ pair.nickname }}
                q-item-label(caption) from: {{ pair.created_at }}
                q-item-label(caption) upto: {{ pair.divorced_at }}
    router-view
</template>

<script>
import notifications from 'notifications';
import {mapActions, mapGetters} from 'vuex'

export default {
  name: 'Settings',
  mixins: [notifications],
  computed: {
    ...mapGetters(['getPair','pairHistory','image'])
  },
  mounted() {
    this.skipDuplicatePageError('Settings')
    this.getPairHistory()
  },
  methods: {
    ...mapActions(['getPairHistory','setRecoverPair']),
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
    },
    skipDuplicatePageError(route) {
      if(this.$route.name !== route) {
        this.$router.replace({ name: route })
      }
    }
  }
}
</script>

<style lang="stylus" scoped>
.my-card
  width: 100%
  max-width: 250px
</style>
