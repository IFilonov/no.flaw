<template lang="pug">
  span
    q-drawer(show-if-above bordered side="left" behavior="desktop" elevated)
      q-list(dense bordered padding class="rounded-borders text-primary text-h6 text-light-blue-8 bold text-weight-bolder")
        q-item(dense clickable v-ripple active-class="my-menu-link" :to="{ name: 'Dates'}")
          q-item-section(avatar)
            q-icon(name="fas fa-users-cog")
          q-item-section Males
        q-item(clickable v-ripple active-class="my-menu-link" :to="{ name: 'Events'}")
          q-item-section(avatar)
            q-icon(name="fas fa-globe")
          q-item-section Events
        q-item(clickable v-ripple active-class="my-menu-link" :to="{ name: 'Wishes'}")
          q-item-section(avatar)
            q-icon(name="fas fa-cubes")
          q-item-section Wishes
    q-page-container
      q-card
        router-view
</template>
