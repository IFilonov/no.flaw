<template lang="pug">
  div(class="q-pa-sm q-gutter-sm")
    q-card(class="q-pa-sm q-gutter-sm")
      q-btn(v-if="!getPair.username"
        class="glossy"
        no-caps
        color="blue"
        @click="onAddPair"
        label="Add female")
      q-chip(v-if="getPair.username"
        title="One click to change or show"
        removable clickable
        @remove="showRemoveFemaleDlg"
        @click="$router.push({ name: 'PairEdit' })"
        text-color="white"
        color="light-blue-8"
        class="glossy"
        size="lg")
        q-avatar(size="40px")
          img(src="https://cdn.quasar.dev/img/avatar2.jpg")
        span {{ getPair.nickname }}
    q-card(class="q-pa-sm q-gutter-sm")
      q-intersection(v-for="(pair) in pairHistory"
        :key="pair.username"
        transition="scale")
        q-chip(v-if="pair.username"
          title="One click to change or show"
          clickable
          text-color="white"
          color="light-blue-8"
          class="glossy"
          size="lg")
          q-avatar(size="40px")
            img(src="https://cdn.quasar.dev/img/avatar2.jpg")
          span {{ pair.nickname }}
    q-dialog(v-model="delFemaleDlg" persistent)
      q-card
        q-card-section(class="row items-center")
          q-avatar
            img(src="https://cdn.quasar.dev/img/avatar2.jpg")
          span(class="q-ml-sm") You are sure delete {{ getPair.username }}?
        q-card-actions(align="right")
          q-btn(flat label="Cancel" color="primary" v-close-popup)
          q-btn(flat label="Delete" @click="deleteFemale" color="primary" v-close-popup)
    router-view
</template>

<script>
import notifications from 'notifications';
import {mapActions, mapGetters} from 'vuex'

export default {
  mixins: [notifications],
  name: "settings",
  data:function() {
    return {
      delFemaleDlg: false
    }
  },
  methods: {
    ...mapActions(['setNames','getPairHistory']),
    skipDuplicatePageError(route) {
      if(this.$route.name !== route) {
        this.$router.replace({name: route})
      }
    },
    onAddPair(){
      this.$router.push({ name: 'PairNew'})
    },
    showRemoveFemaleDlg() {
      this.delFemaleDlg = true;
    },
    async deleteFemale() {
      this.delFemaleDlg = false;
      const response = await this.$api.male.delFemale();
      if(response.data.error) {
        this.showErrNotif(response.data);
      }
      else {
        this.showNotif(`${this.getPair.nickname} deleted`);
        this.setNames(response.data)
        this.getPairHistory()
      }
    }
  },
  computed: {
    ...mapGetters(['getPair','pairHistory'])
  },
  mounted() {
    this.skipDuplicatePageError('Settings')
    this.getPairHistory()
  }
}
</script>

<style lang="stylus">
.example-item
  height: 60px
  width: 60px
</style>
