<template lang="pug">
  span
    q-drawer(show-if-above bordered side="left" behavior="desktop" elevated)
      q-list(bordered padding class="text-grey-7 text-bold")
        q-item(clickable v-ripple active-class="my-menu-link" :to="{ name: 'Settings'}")
          q-item-section(avatar)
            q-icon(name="fas fa-cubes")
          q-item-section
            q-item-label PAIR
        q-item(clickable v-ripple active-class="my-menu-link" :to="{ name: 'Dates'}")
          q-item-section(avatar)
            q-icon(name="fas fa-users-cog")
          q-item-section
            q-item-label DATES
        q-separator(inset)
        q-item(clickable v-ripple active-class="my-menu-link")
          q-item-section(avatar)
            q-icon(name="fas fa-globe")
          q-item-section
            q-item-label TASKS
          q-item-section(side top)
            q-item-label(caption) >5 min ago
              q-icon(name="star" color="green")
    q-page-container
      router-view
</template>
