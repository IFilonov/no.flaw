<template lang="pug">
  div
    q-layout
      navbar(:user = "user" :logout_path="$api.staff.logout")
      dashboard
</template>

<script>
import navbar from '../shared/navbar';
import dashboard from './dashboard';
export default {
  components: {
    'navbar': navbar,
    'dashboard': dashboard
  },
  data: function () {
    return {
      user: null
    }
  },
  methods: {
    async getUser() {
      const response = await this.$api.staff.user();
      this.user = response.data.user;
    }
  },
  mounted() {
    this.getUser();
  }
}
</script>
