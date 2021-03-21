<template lang="pug">
  q-header(elevated class="bg-grey-6 text-white")
    q-toolbar(class="glossy")
      q-toolbar-title
        q-avatar(size="48px")
          img(:src="image()")
        span {{ name }}
      div(class="q-pa-md")
        q-btn-dropdown(class="glossy" color="purple" label="Account Settings")
          div(class="row no-wrap q-pa-md")
            div(class="column")
              div(class="text-h6 q-mb-md") Settings
            q-separator(vertical inset class="q-mx-lg")
            div(class="column items-center")
              q-avatar(size="72px")
                img(:src="image()")
              div(class="text-subtitle1 q-mt-md q-mb-xs") {{ name }}
              q-btn(:href="logoutPath" type="a" color="primary" label="Logout" push size="sm" v-close-popup)
</template>

<script>
import {mapGetters} from 'vuex'
export default {
  props: {
    name: {
      type: String,
      required: true,
      default: null
    },
    logoutPath: {
      type: String,
      required: false,
      default: null
    }
  },
  data: function () {
    return {
    }
  },
  computed: {
    ...mapGetters(['image'])
  }
}
</script>
