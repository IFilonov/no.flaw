<template lang="pug">
  div(class="q-pa-md q-gutter-sm")
    q-btn(v-if="!female_name" class="glossy" no-caps color="blue" @click="showAddFemaleDlg" label="Add female")
    q-chip(v-if="female_name" removable @remove="showRemoveFemaleDlg" text-color="white" color="light-blue-8" class="glossy")
      q-avatar
        img(src="https://cdn.quasar.dev/img/avatar2.jpg")
      b {{ female_name }}
    q-dialog(v-model="addFemaleDlg" persistent)
      q-card
        q-card-section(class="row items-center")
          q-form(class="q-gutter-md" @submit="addFemale" @reset="female=''")
            q-input(filled label="Female name *" hint="Name"
              v-model="female.username"
              lazy-rules :rules="[ val => val && val.length > 5 || 'Please type Fullname > 5 chars']")
            q-input(filled label="Password" hint="password" type="password"
              v-model="female.password"
              lazy-rules :rules="[ val => val && val.length > 5 || 'Please type password > 5 chars']")
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
    ...mapActions(['setFemaleName']),
    showAddFemaleDlg() {
      this.addFemaleDlg = true;
    },
    showRemoveFemaleDlg() {
      this.delFemaleDlg = true;
    },
    async addFemale() {
      try {
        this.addFemaleDlg = false;
        const response = await this.$api.male.addFemale({ female: this.female });
        if(response.data.username) {
          this.setFemaleName(response.data.female_name);
          this.showNotif(`${response.data.username} created`);
        }
        else
        {
          console.log(response.data[0]);
          this.showErrNotif(response.data[0]);
        }
      } catch(err)  {
      }
    },
    async deleteFemale() {
      try {
        this.delFemaleDlg = false;
        const response = await this.$api.male.delFemale({ female: this.female });
        if(response.data.username) {
          this.setFemaleName('');
          this.showNotif(`${response.data.username} created`);
        }
        else
        {
          this.showErrNotif(response.data[0]);
        }
      } catch(err)  {
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