<template lang="pug">
  div(class="q-pa-md q-gutter-sm")
    q-dialog(v-model="newPairDlg"
      persistent
      @hide="toSettings")
      q-card
        q-card-section(class="row items-center")
          q-form(class="q-gutter-md" @submit="setPair" @reset="pair={}")
            q-avatar
              img(:src="image(true)")
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
    q-dialog(v-model="updPairDlg"
      persistent
      @hide="toSettings")
      q-card
        q-card-section(class="row items-center")
          q-form(class="q-gutter-md" @submit="updPair")
            q-avatar
              img(:src="image(true)")
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
          span(class="q-ml-sm") You are sure change {{ getPair.username }} to {{ getRecoveredPair.username }}?
        q-card-actions(align="right")
          q-btn(flat label="Cancel" color="primary" v-close-popup)
          q-btn(flat label="Change" @click="changePair" color="primary" v-close-popup)
</template>

<script>
import notifications from 'notifications';
import {mapActions, mapGetters} from 'vuex'

export default {
  name: 'Settings',
  mixins: [notifications],
  data:function() {
    return {
      pair: {},
      newPairDlg: false,
      updPairDlg: false,
      delPairDlg: false,
      recoverPairDlg: false
    }
  },
  computed: {
    ...mapGetters(['getPair','pairHistory','getRecoveredPair','image'])
  },
  created() {
    this.processState(this.$route.name)
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
      this.updPairDlg = false;
      this.updatePair({ pair }).then((data) =>{
        data.error
          ? this.showErrNotif(data)
          : this.showNotif(`${ data.pair.username } updated`);
        this.getPairHistory()
      })
    },
    processState(state) {
      this.pair = { ...this.getPair }
      switch(state) {
      case 'PairEdit':
        this.updPairDlg = true;
        break;
      case 'PairNew':
        if(process.env.NODE_ENV === 'development') {
          this.fillPairRandom();
        }
        this.newPairDlg = true;
        break;
      case 'PairDelete':
        this.delPairDlg = true;
        break;
      case 'PairChange':
        this.recoverPairDlg = true;
        break;
      case 'PairRevert':
        this.revertPair()
        this.toSettings()
        break;
      default:
      }
    },
    async changePair(){
      const response = await this.$api.pair.delete(this.pair.id);
      if(response.data.error) {
        this.showErrNotif(response.data);
      }
      else {
        this.showNotif(`${this.getPair.username} deleted`);
        await this.revertPair()
      }
    },
    async revertPair() {
      const response = await this.$api.pair.restore(this.getRecoveredPair.id);
      if(response.data.error) {
        this.showErrNotif(response.data);
      }
      else {
        this.showNotif(`${this.getRecoveredPair.username} restored`);
        this.setNames(response.data)
        this.getPairHistory()
      }
    },
    fillPairRandom(){
      this.pair.username = Math.random().toString(36).substring(3);
      this.pair.nickname = Math.random().toString(36).substring(3);
      this.pair.password = 'password';
    },
    async deletePair() {
      this.delPairDlg = false;
      const response = await this.$api.pair.delete(this.pair.id);
      if(response.data.error) {
        this.showErrNotif(response.data);
      }
      else {
        this.showNotif(`${this.getPair.username} deleted`);
        this.setNames(response.data)
        this.getPairHistory()
      }
    }
  }
}
</script>
