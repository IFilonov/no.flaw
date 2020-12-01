<template lang="pug">
  #qnavbar
    q-header(elevated class="bg-light-blue-8 text-white")
      q-toolbar(class="glossy")
        q-toolbar-title
          b NoFlaw
          q-avatar
            img(src="https://cdn.quasar.dev/img/boy-avatar.png")
        div(class="q-pa-md")
          q-btn-dropdown(class="glossy" color="purple" label="Account Settings")
            div(class="row no-wrap q-pa-md")
              div(class="column")
                div(class="text-h6 q-mb-md") Settings

              q-separator(vertical inset class="q-mx-lg")

              div(class="column items-center")
                q-avatar(size="72px")
                  img(src="https://cdn.quasar.dev/img/boy-avatar.png")
                div(class="text-subtitle1 q-mt-md q-mb-xs") username

                q-btn(:href="user_logout_path" type="a" color="primary" label="Logout" push size="sm" v-close-popup)
</template>

<script>
export default {
  data: function () {
    return {
    }
  }
}
</script>
