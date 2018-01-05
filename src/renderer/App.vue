<template>
  <v-app id="inspire">
    <sidebar :drawer="drawer" />
    <v-toolbar color="blue-grey darken-3" dark flat dense app>
      <!-- <v-toolbar-side-icon @click.stop="drawer = !drawer"></v-toolbar-side-icon> -->
      <v-toolbar-title>Application</v-toolbar-title>
    </v-toolbar>
    <v-content>
      <v-container fluid fill-height>
        <!-- <v-layout justify-center align-center> -->
        <v-layout>
          <router-view></router-view>
        </v-layout>
      </v-container>
    </v-content>
    <v-footer color="blue-grey darken-3" app>
      <span class="white--text">&copy; Ксения Волкова, 2018</span>
    </v-footer>
  </v-app>
</template>

<script>
import Sidebar from '@/components/Sidebar'
export default {
  name: 'dblab',
  data: () => ({
    drawer: false
  }),
  components: {
    sidebar: Sidebar
  }
}
</script>

<style>
  /* CSS */
@font-face {
  font-family: 'Material Icons';
  font-style: normal;
  font-weight: 400;
  src: url("./assets/material-icons.woff2") format('woff2');
}

.material-icons {
  font-family: 'Material Icons';
  font-weight: normal;
  font-style: normal;
  font-size: 24px;
  line-height: 1;
  letter-spacing: normal;
  text-transform: none;
  display: inline-block;
  white-space: nowrap;
  word-wrap: normal;
  direction: ltr;
  -webkit-font-feature-settings: 'liga';
  -webkit-font-smoothing: antialiased;
}
</style>
