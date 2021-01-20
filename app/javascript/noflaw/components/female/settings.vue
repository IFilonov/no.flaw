<template lang="pug">
  div(class="q-pa-md q-gutter-sm")
    q-btn(v-if="!male_name" class="glossy" no-caps color="blue" @click="showAddMaleDlg" label="Add male")
    q-chip(v-if="male_name" removable @remove="showRemoveMaleDlg" text-color="white"
        color="light-blue-8" class="glossy" size="lg")
      q-avatar(size="40px")
        img(src="https://cdn.quasar.dev/img/avatar4.jpg")
      span {{ male_name }}
    q-dialog(v-model="addMaleDlg" persistent)
      q-card
        q-card-section(class="row items-center")
          q-form(class="q-gutter-md" @submit="addMale" @reset="male=''")
            q-input(filled label="Male name *" hint="Name"
              v-model="male.username"
              lazy-rules :rules="[ val => val && val.length > 0 || 'Please type male name']")
            q-input(filled label="Password" hint="password" type="password"
              v-model="male.password"
              lazy-rules :rules="[ val => val && val.length > 0 || 'Please type password']")
            div
              q-btn(label="Submit" type="submit" color="primary")
              q-btn(label="Reset" type="reset" color="primary" flat class="q-ml-sm")
              q-btn(flat label="Cancel" color="primary" v-close-popup)
    q-dialog(v-model="delMaleDlg" persistent)
      q-card
        q-card-section(class="row items-center")
          q-avatar
            img(src="https://cdn.quasar.dev/img/avatar4.jpg")
          span(class="q-ml-sm") You are sure delete {{ male_name }}?
        q-card-actions(align="right")
          q-btn(flat label="Cancel" color="primary" v-close-popup)
          q-btn(flat label="Delete" @click="deleteMale" color="primary" v-close-popup)
</template>

<script>
import notifications from 'notifications';
import {mapActions, mapState} from 'vuex'

export default {
  mixins: [notifications],
  name: "settings",
  data:function() {
    return {
      male: {
        username: '',
        password: ''
      },
      addMaleDlg: false,
      delMaleDlg: false
    }
  },
  methods: {
    ...mapActions(['setMaleName']),
    showAddMaleDlg() {
      this.addMaleDlg = true;
    },
    showRemoveMaleDlg() {
      this.delMaleDlg = true;
    },
    async addMale() {
      try {
        this.addMaleDlg = false;
        const response = await this.$api.female.addMale({ male: this.male });
        if(response.data.username) {
          this.setMaleName(response.data.username);
          this.showNotif(`${response.data.username} created`);
        }
        else
        {
          this.showErrNotif(response.data[0]);
        }
      } catch(err)  {
      }
    },
    async deleteMale() {
      try {
        this.delMaleDlg = false;
        await this.$api.female.delMale();
        this.showNotif(`${this.male_name} deleted`);
        this.setMaleName(null);

      } catch(err)  {
        this.showErrNotif(`${this.male_name} not deleted`);
      }
    }
  },
  computed: {
    ...mapState(['male_name']),
  }
}
</script>

<style scoped>

</style>