<template lang="pug">
  span
    q-drawer(show-if-above bordered side="left" behavior="desktop" elevated)
      q-list(bordered padding class="text-light-blue-9 text-bold text-h6")
        q-item(clickable v-ripple active-class="my-menu-link" :to="{ name: 'Dates'}")
          q-item-section(avatar)
            q-icon(name="fas fa-users-cog")
          q-item-section
            q-item-label Dates
        q-separator(inset)
        q-item(clickable v-ripple active-class="my-menu-link" :to="{ name: 'Settings2'}")
          q-item-section(avatar)
            q-icon(name="fas fa-globe")
          q-item-section
            q-item-label Events
          q-item-section(side top)
            q-item-label(caption) >5 min ago
              q-icon(name="star" color="green")
        q-separator(inset)
        q-item(clickable v-ripple active-class="my-menu-link" :to="{ name: 'Settings3'}")
          q-item-section(avatar)
            q-icon(name="fas fa-cubes")
          q-item-section
            q-item-label Wishes
        q-separator(inset)
        q-item(clickable v-ripple active-class="my-menu-link" :to="{ name: 'Settings'}")
          q-item-section(avatar)
            q-icon(name="fas fa-cubes")
          q-item-section
            q-item-label Male
    q-page-container
      router-view
</template>
