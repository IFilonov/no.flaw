<template lang="pug">
  div
    q-layout
      navbar(:name = "name" :logout_path="$api.female.logout" :img="img")
      dashboard
</template>

<script>
import navbar from '../shared/navbar';
import dashboard from './dashboard';
import {mapActions, mapState} from 'vuex'

export default {
  components: {
    'navbar': navbar,
    'dashboard': dashboard
  },
  data: function () {
    return {
      name: '',
      img: "https://cdn.quasar.dev/img/avatar2.jpg"
    }
  },
  methods: {
    ...mapActions(['setMaleName']),
    async getUser() {
      const response = await this.$api.female.info();
      this.name = response.data.name;
      this.setMaleName(response.data.male_name);
    }
  },
  computed: {
    ...mapState(['male_name']),
  },
  mounted() {
    this.getUser();
  }
}
</script>
