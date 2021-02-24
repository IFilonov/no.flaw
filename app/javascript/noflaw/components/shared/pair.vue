<template lang="pug">
  div(class="q-pa-md q-gutter-sm")
    q-dialog(v-model="addFemaleDlg"
      persistent
      @hide="onHide")
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
      addFemaleDlg: false
    }
  },
  methods: {
    ...mapActions(['setFemaleName']),
    onHide() {
      this.$router.push({ name: 'Settings' })
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
    }
  },
  computed: {
    ...mapState(['female_name']),
  },
  created() {
    this.addFemaleDlg = true
  }
}
</script>
