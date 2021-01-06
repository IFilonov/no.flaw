<template lang="pug">
  div
    q-layout
      navbar(:user = "name" :logout_path="$api.female.logout")
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
  methods: {
    async getUser() {
      const response = await this.$api.female.info();
      this.name = response.data.name;
    }
  },
  mounted() {
    this.getUser();
  }
}
</script>
