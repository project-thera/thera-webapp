<template>
  <v-app>
    <Navbar />
    <v-main>
      <v-container fluid class="ps-4">
        <router-view />
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
export default {
  name: "App",
  data() {
    return {};
  }
};
</script>

<style lang="scss" scoped>
@import "@/assets/stylesheets/_variables.scss";

.v-application {
  font-family: $primary-font-family;
}

// h1,
// h2 {
//   font-weight: 600;
// }
</style>
