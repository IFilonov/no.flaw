<template lang="pug">
  div
    q-layout
      navbar(:name = "getMe.username" :logoutPath="$api.female.logout")
      dashboard
</template>

<script>
import navbar from '../shared/navbar';
import dashboard from '../shared/dashboard';
import {mapActions, mapGetters} from 'vuex'

export default {
  components: {
    'navbar': navbar,
    'dashboard': dashboard
  },
  computed: {
    ...mapGetters(['getMe'])
  },
  mounted() {
    this.loadNames();
  },
  methods: {
    ...mapActions(['loadNames'])
  }
}
</script>
