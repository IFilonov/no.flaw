<template lang="pug">
  div(class="q-pa-md q-gutter-sm")
    q-btn(v-if="!female_name" class="glossy" no-caps color="blue" @click="showAddFemaleDlg" label="Add female")
    q-chip(v-if="female_name" removable @remove="showRemoveFemaleDlg" text-color="white" color="light-blue-8"
      class="glossy" size="lg")
      q-avatar(size="40px")
        img(src="https://cdn.quasar.dev/img/avatar2.jpg")
      b {{ female_name }}
    q-dialog(v-model="addFemaleDlg" persistent)
      q-card
        q-card-section(class="row items-center")
          q-form(class="q-gutter-md" @submit="addFemale" @reset="female=''")
            q-input(filled label="Female name *" hint="Name"
              v-model="female.username"
              lazy-rules :rules="[ val => val && val.length > 0 || 'Please type female name']")
            q-input(filled label="Password" hint="password" type="password"
              v-model="female.password"
              lazy-rules :rules="[ val => val && val.length > 0 || 'Please type password']")
            div
              q-btn(label="Submit" type="submit" color="primary")
              q-btn(label="Reset" type="reset" color="primary" flat class="q-ml-sm")
              q-btn(flat label="Cancel" color="primary" v-close-popup)
    q-dialog(v-model="delFemaleDlg" persistent)
      q-card
        q-card-section(class="row items-center")
          q-avatar
            img(src="https://cdn.quasar.dev/img/avatar2.jpg")
          span(class="q-ml-sm") You are sure delete {{ female_name }}?
        q-card-actions(align="right")
          q-btn(flat label="Cancel" color="primary" v-close-popup)
          q-btn(flat label="Delete" @click="deleteFemale" color="primary" v-close-popup)
</template>

<script>
import notifications from 'notifications';
import {mapActions, mapState} from 'vuex'

export default {
  mixins: [notifications],
  name: "settings",
  data:function() {
    return {
      female: {
        username: '',
        password: ''
      },
      addFemaleDlg: false,
      delFemaleDlg: false
    }
  },
  methods: {
    ...mapActions(['setFemaleName','getNames','setNames']),
    showAddFemaleDlg() {
      this.addFemaleDlg = true;
    },
    showRemoveFemaleDlg() {
      this.delFemaleDlg = true;
    },
    async addFemale() {
      this.addFemaleDlg = false;
      const response = await this.$api.male.addFemale({ female: this.female });
      if(response.data.error) {
        this.showErrNotif(response.data);
      }
      else {
        this.setFemaleName(response.data)
        this.showNotif(`${this.female_name} created`);
      }
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

<style scoped>

</style>