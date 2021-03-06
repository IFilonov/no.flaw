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
    q-dialog(v-model="editPairDlg"
      persistent
      @hide="onHide")
      q-card
        q-card-section(class="row items-center")
          q-form(class="q-gutter-md" @submit="updPair")
            q-input(filled label="Pair login *" hint="Login"
              v-model="pair.username")
            q-input(filled label="Pair nickname *" hint="Nickname"
              v-model="pair.nickname")
            q-input(filled label="Password" hint="password" type="password"
              v-model="pair.password"
              lazy-rules :rules="[ val => val && val.length > 5 || 'Please type password']")
            div
              q-btn(label="Update" type="submit" color="primary")
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
      pairDlg: false,
      editPairDlg: false
    }
  },
  methods: {
    ...mapActions(['addPair','setRecoverPairId','updatePair']),
    onHide() {
      this.$router.push({ name: 'Settings' })
      this.setRecoverPairId( null )
    },
    setPair() {
     this.pairDlg = false;
     let pair = this.pair
     if(this.getRecoverPairId) {
       pair.recover = true
     }
     this.setRecoverPairId( null )
     this.addPair({ pair }).then((data) =>{
       data.error ?
         this.showErrNotif(data) : this.showNotif(`${ data.pair.nickname } created`);
     })
    },
    updPair() {
      this.editPairDlg = false;
      let pair = this.pair
      this.updatePair({ pair }).then((data) =>{
        data.error ?
            this.showErrNotif(data) : this.showNotif(`${ data.pair.nickname } updated`);
      })
    }
  },
  computed: {
    ...mapGetters(['getPair','pairHistory','getRecoverPairId'])
  },
  created() {
    this.$route.name === 'PairEdit' ? this.editPairDlg = true : this.pairDlg = true
    this.pair = { ...this.getPair }

    //!!!!temporary!!!
    if(!this.pair.username && !this.getRecoverPairId) {
      this.pair.username = Math.random().toString(36).substring(3);
      this.pair.nickname = Math.random().toString(36).substring(3);
      this.pair.password = 'password';
    }
    if(this.getRecoverPairId) {
      this.pair.username = this.pairHistory[this.getRecoverPairId].username;
      this.pair.nickname = this.pairHistory[this.getRecoverPairId].nickname;
      this.pair.password = 'password';
    }
  },
  mounted() {
  }
}
</script>
