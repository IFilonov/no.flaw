<template lang="pug">
  div(class="q-pa-md q-gutter-sm")
    q-dialog(v-model="pairDlg"
      persistent
      @hide="onHide")
      q-card
        q-card-section(class="row items-center")
          q-form(class="q-gutter-md" @submit="setPair" @reset="pair={}")
            q-input(filled label="Your pair login *" hint="Login"
              v-model="pair.username"
              lazy-rules :rules="[ val => val && val.length > 0 || 'Please type your pair login']")
            q-input(filled label="Your pair nickname *" hint="Nickname"
              v-model="pair.nickname")
            q-input(filled label="Password" hint="password" type="password"
              v-model="pair.password"
              lazy-rules :rules="[ val => val && val.length > 5 || 'Please type password']")
            div
              q-btn(label="Submit" type="submit" color="primary")
              q-btn(label="Reset" type="reset" color="primary" flat class="q-ml-sm")
              q-btn(flat label="Cancel" color="primary" v-close-popup)
</template>

<script>
import notifications from 'notifications';
import {mapActions, mapGetters} from 'vuex'

export default {
  mixins: [notifications],
  name: "settings",
  data:function() {
    return {
      pair: {},
      pairDlg: false
    }
  },
  methods: {
    ...mapActions(['addPair']),
    onHide() {
      this.$router.push({ name: 'Settings' })
    },
    setPair() {
     this.pairDlg = false;
     let pair = this.pair
     this.addPair({ pair }).then((data) =>{
       data.error ?
         this.showErrNotif(data) : this.showNotif(`${ data.pair.nickname } saved`);
     })
    }
  },
  computed: {
    ...mapGetters(['getPair']),
  },
  created() {
    this.pairDlg = true
    this.pair = { ...this.getPair }

    //!!!!temporary!!!
    if(!this.pair.username) {
      this.pair.username = Math.random().toString(36).substring(3);
      this.pair.nickname = Math.random().toString(36).substring(3);
      this.pair.password = 'password';
    }
  },
  mounted() {
  }
}
</script>
