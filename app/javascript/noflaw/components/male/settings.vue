<template lang="pug">
  div(class="q-pa-md q-gutter-sm")
    q-btn(v-if="!female_name"
      class="glossy"
      no-caps
      color="blue"
      @click="$router.push({ name: 'Pair' })"
      label="Add female")
    q-chip(v-if="female_name"
      removable clickable
      @remove="showRemoveFemaleDlg"
      @click="editDlg = true"
      text-color="white"
      color="light-blue-8"
      class="glossy"
      size="lg")
      q-avatar(size="40px")
        img(src="https://cdn.quasar.dev/img/avatar2.jpg")
      b {{ female_name }}
    q-dialog(v-model="delFemaleDlg" persistent)
      q-card
        q-card-section(class="row items-center")
          q-avatar
            img(src="https://cdn.quasar.dev/img/avatar2.jpg")
          span(class="q-ml-sm") You are sure delete {{ female_name }}?
        q-card-actions(align="right")
          q-btn(flat label="Cancel" color="primary" v-close-popup)
          q-btn(flat label="Delete" @click="deleteFemale" color="primary" v-close-popup)
    router-view
</template>

<script>
import notifications from 'notifications';
import {mapActions, mapState} from 'vuex'

export default {
  mixins: [notifications],
  name: "settings",
  data:function() {
    return {
      delFemaleDlg: false
    }
  },
  methods: {
    ...mapActions(['setNames']),
    showRemoveFemaleDlg() {
      this.delFemaleDlg = true;
    },
    async deleteFemale() {
      this.delFemaleDlg = false;
      const response = await this.$api.male.delFemale();
      if(response.data.error) {
        this.showErrNotif(response.data);
      }
      else {
        this.showNotif(`${this.female_name} deleted`);
        this.setNames(response.data)
      }
    }
  },
  computed: {
    ...mapState(['female_name']),
  }
}
</script>
