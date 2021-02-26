<template lang="pug">
  div(class="q-pa-md q-gutter-sm")
    q-dialog(v-model="addPairDlg"
      persistent
      @hide="onHide")
      q-card
        q-card-section(class="row items-center")
          q-form(class="q-gutter-md" @submit="addFemale" @reset="female=''")
            q-input(filled label="Female login *" hint="Login"
              v-model="female.username"
              lazy-rules :rules="[ val => val && val.length > 0 || 'Please type female login']")
            q-input(filled label="Female nickname *" hint="Name"
              v-model="female.nickname"
              lazy-rules :rules="[ val => val && val.length > 0 || 'Please type female name/nickname']")
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
        password: '',
        nickname: ''
      },
      addPairDlg: false
    }
  },
  methods: {
    ...mapActions(['setFemaleName']),
    onHide() {
      this.$router.push({ name: 'Settings' })
    },
    async addFemale() {
      this.addPairDlg = false;
      const response = await this.$api.male.addFemale({ female: this.female });
      if(response.data.error) {
        this.showErrNotif(response.data);
      }
      else {
        this.setFemaleName(response.data)
        this.showNotif(`${response.data.female_name} created`);
      }
    }
  },
  computed: {
    ...mapState(['female_name']),
    name() {
      return this.$route.params.name
    }
  },
  created() {
    this.addPairDlg = true
    this.female.username = this.female_name
  },
  mounted() {
    console.log(this.name);
    console.log(this.$route);
  }
}
</script>
