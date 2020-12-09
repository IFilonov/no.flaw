<template lang="pug">
  div
    q-layout
      navbar(:user = "user" :user_logout_path="$api.staff.logout")
</template>

<script>
import navbar from '../shared/navbar';
export default {
  components: {
    'navbar': navbar
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
