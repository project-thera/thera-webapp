<template>
  <div>
    <v-app-bar app>
      <v-app-bar-nav-icon
        tile
        x-large
        class="white--text hidden-lg-and-up"
        :ripple="false"
        :title="$t('views.actions.menu')"
        @click="drawer = !drawer"
      >
        <v-icon>{{ $vuetify.icons.values.menu }}</v-icon>
      </v-app-bar-nav-icon>

      <router-link v-if="!lgAndUp" to="/admin/usuarios">
        <!-- <v-img class="mx-2 brand-logo" contain :src="Logo" /> -->
      </router-link>

      <!-- <v-spacer /> -->

      <!-- <portal-target name="search-input" /> -->

      <!-- <v-spacer /> -->

      <UserMenu />
    </v-app-bar>

    <SideNav :drawer="drawer" />
  </div>
</template>

<script>
// import Logo from "@/assets/images/isologotipo_b_blanco.svg";

export default {
  name: "Navbar",
  data() {
    return {
      // Logo,
      drawer: false
    };
  },
  computed: {
    lgAndUp() {
      return this.$vuetify.breakpoint.lgAndUp;
    }
  }
};
</script>

<style lang="scss" scoped>
@import "@/assets/stylesheets/_variables.scss";
// @import '../../assets/styles/main.scss';

.v-app-bar {
  background-color: $primary-color !important;
  left: 0px !important;
  z-index: 7;
}

$header-height: 64px;

// header {
//   height: $header-height;
// }

::v-deep .v-toolbar__content {
  padding-bottom: 0;
  padding-top: 0;
}

.brand {
  width: 156px;
  height: 100%;
  padding-bottom: 8px;
}

.brand-logo {
  max-width: 140px;
  height: 62px;
}

::v-deep .v-toolbar__content > .v-btn.v-btn--icon:first-child {
  margin-left: -16px;
}

::v-deep .v-toolbar__content > .v-btn.v-btn--icon:last-child {
  margin-right: -16px;
}

::v-deep .v-btn--icon:hover {
  background-color: rgba(0, 0, 0, 0.3);
}

::v-deep .v-btn--icon.v-size--x-large {
  height: 100%;
  //Los botones son cuadrados
  width: $header-height;
}
</style>
