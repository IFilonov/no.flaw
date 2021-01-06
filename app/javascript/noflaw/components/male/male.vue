<template lang="pug">
  div
    q-layout
      navbar(:name = "name" :logout_path="$api.male.logout")
      dashboard
</template>

<script>
import navbar from '../shared/navbar';
import dashboard from './dashboard';
import { mapActions } from 'vuex'

export default {
  components: {
    'navbar': navbar,
    'dashboard': dashboard
  },
  data: function () {
    return {
      name: ''
    }
  },
  methods: {
    ...mapActions(['setFemaleName']),
    async getUser() {
      const response = await this.$api.male.info();
      this.name = response.data.name;
      this.setFemaleName(response.data.female_name);
    }
  },
  mounted() {
    this.getUser();
  }
}
</script>
