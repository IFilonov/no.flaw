<template lang="pug">
  div
    q-layout
      navbar(:name = "userName" :logout_path="$api.male.logout" :img="img")
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
      img: "https://cdn.quasar.dev/img/avatar4.jpg"
    }
  },
  methods: {
    ...mapActions(['getNames'])
  },
  computed: {
    ...mapGetters(['userName'])
  },
  mounted() {
    this.getNames();
  }
}
</script>
