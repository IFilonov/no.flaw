<template lang="pug">
  div
    q-layout
      navbar(:name = "nickName" :logout_path="$api.female.logout" :img="img")
      dashboard
</template>

<script>
import navbar from '../shared/navbar';
import dashboard from './dashboard';
import {mapActions, mapGetters} from 'vuex'

export default {
  components: {
    'navbar': navbar,
    'dashboard': dashboard
  },
  data: function () {
    return {
      img: "https://cdn.quasar.dev/img/avatar2.jpg"
    }
  },
  methods: {
    ...mapActions(['getNames']),
  },
  computed: {
    ...mapGetters(['nickName']),
  },
  mounted() {
    this.getNames();
  }
}
</script>
