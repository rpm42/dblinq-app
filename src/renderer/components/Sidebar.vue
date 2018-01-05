<template>
  <v-navigation-drawer clipped permanent app>
    <v-list dense>
      <v-list-tile @click="$router.push('/connect')">
        <v-list-tile-content>
          <v-list-tile-title>Connect</v-list-tile-title>
        </v-list-tile-content>
      </v-list-tile>
      <v-list-tile @click="$router.push('/create-tables')">
        <v-list-tile-content>
          <v-list-tile-title>Create tables</v-list-tile-title>
        </v-list-tile-content>
      </v-list-tile>
      <v-list-tile @click="$router.push('/connect')">
        <v-list-tile-content>
          <v-list-tile-title>LINQ</v-list-tile-title>
        </v-list-tile-content>
      </v-list-tile>
    </v-list>
  </v-navigation-drawer>
</template>

<script>
export default {
  name: 'Sidebar',
  props: ['drawer']
}
</script>
