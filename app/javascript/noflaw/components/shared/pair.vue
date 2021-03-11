<template lang="pug">
  div(class="q-pa-md q-gutter-sm")
    q-dialog(v-model="newPairDlg"
      persistent
      @hide="toSettings")
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
      @hide="toSettings")
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
    q-dialog(v-model="delPairDlg"
      persistent
      @hide="toSettings")
      q-card
        q-card-section(class="row items-center")
          q-avatar
            img(:src="image(true)")
          span(class="q-ml-sm") You are sure delete {{ getPair.username }}?
        q-card-actions(align="right")
          q-btn(flat label="Cancel" color="primary" v-close-popup)
          q-btn(flat label="Delete" @click="deletePair" color="primary" v-close-popup)
    q-dialog(v-model="recoverPairDlg"
      persistent
      @hide="toSettings")
      q-card
        q-card-section(class="row items-center")
          q-avatar
            img(:src="image(true)")
          span(class="q-ml-sm") You are sure change {{ getPair.username }} to {{ pair.username }}?
        q-card-actions(align="right")
          q-btn(flat label="Cancel" color="primary" v-close-popup)
          q-btn(flat label="Change" @click="changePair" color="primary" v-close-popup)
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
      newPairDlg: false,
      editPairDlg: false,
      delPairDlg: false,
      recoverPairDlg: false
    }
  },
  methods: {
    ...mapActions(['addPair','setNames','updatePair','getPairHistory']),
    toSettings() {
      this.$router.push({ name: 'Settings' })
    },
    setPair() {
     this.newPairDlg = false;
     let pair = this.pair
     this.addPair({ pair }).then((data) =>{
       data.error
           ? this.showErrNotif(data)
           : this.showNotif(`${ data.pair.username } created`);
     })
    },
    updPair() {
      let pair = this.pair
      this.updatePair({ pair }).then((data) =>{
        data.error
            ? this.showErrNotif(data)
            : this.showNotif(`${ data.pair.username } updated`);
      })
    },
    async changePair(){
      const response = await this.$api.pair.delete();
      if(response.data.error) {
        this.showErrNotif(response.data);
      }
      else {
        this.showNotif(`${this.getPair.username} deleted`);
        this.restorePair()
      }
    },
    processState(state) {
      switch(state) {
        case 'PairEdit':
          this.pair = { ...this.getPair }
          this.editPairDlg = true;
          break;
        case 'PairNew':
          this.fillPairRandom();
          this.newPairDlg = true;
          break;
        case 'PairDelete':
          this.delPairDlg = true;
          break;
        case 'PairChange':
          this.fillPairRecovered();
          this.recoverPairDlg = true;
          break;
        case 'PairRevert':
          this.restorePair()
          this.toSettings()
          break;
        default:
      }
    },
    async restorePair() {
      let pair = { ...this.getRecoveredPair }
      const response = await this.$api.pair.restore(pair);
      if(response.data.error) {
        this.showErrNotif(response.data);
      }
      else {
        this.showNotif(`${pair.username} restored`);
        this.setNames(response.data)
        this.getPairHistory()
      }
    },
    fillPairRandom(){
      this.pair.username = Math.random().toString(36).substring(3);
      this.pair.nickname = Math.random().toString(36).substring(3);
      this.pair.password = 'password';
    },
    fillPairRecovered(){
      this.pair = { ...this.getRecoveredPair }
      this.pair.password = 'password';
    },
    async deletePair() {
      this.delPairDlg = false;
      const response = await this.$api.pair.delete();
      if(response.data.error) {
        this.showErrNotif(response.data);
      }
      else {
        this.showNotif(`${this.getPair.username} deleted`);
        this.setNames(response.data)
        this.getPairHistory()
      }
    }
  },
  computed: {
    ...mapGetters(['getPair','pairHistory','getRecoveredPair','image'])
  },
  created() {
    this.processState(this.$route.name)
  },
  mounted() {
  }
}
</script>
