<template lang="pug">
  div
    q-layout
      navbar(:user = "name" :logout_path="$api.staff.logout")
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
      name: null
    }
  },
  mounted() {
    this.getUser();
  },
  methods: {
    async getUser() {
      const response = await this.$api.staff.info();
      this.name = response.data.name;
    }
  }
}
</script>
