<template lang="pug">
  div
    q-layout
      navbar(:name = "getMe.username" :logoutPath="$api.male.logout")
      dashboard
</template>

<script>
import navbar from '../shared/navbar';
import dashboard from '../shared/dashboard';
import {mapGetters} from 'vuex'

export default {
  components: {
    'navbar': navbar,
    'dashboard': dashboard
  },
  computed: {
    ...mapGetters(['getMe'])
  }
}
</script>
