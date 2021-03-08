<template>
  <div>
    <v-navigation-drawer v-model="isOpen" app width="275px" class="pt-12">
      <!-- <v-img class="mx-8" aspect-ratio="1.7" contain :src="Logo" /> -->

      <v-list nav>
        <v-list-item
          v-for="link in visibleLinks"
          :key="link.title"
          router
          :to="{ name: link.route }"
        >
          <v-list-item-icon class="mr-2">
            <v-icon class="ml-4">
              {{ link.icon }}
            </v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title>
              {{ link.title }}
            </v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>

      <v-divider />

      <v-list v-if="visibleAdminLinks.length > 0">
        <v-list-group class="theme--light">
          <v-list-item slot="activator" class="pa-0">
            <v-list-item-icon class="mr-2">
              <v-icon class="ml-4">{{
                $vuetify.icons.values.cogOutline
              }}</v-icon>
            </v-list-item-icon>
            <v-list-item-content>
              <v-list-item-title>
                {{ $t("views.menu.administration") }}
              </v-list-item-title>
            </v-list-item-content>
          </v-list-item>

          <v-list-item
            v-for="link in visibleAdminLinks"
            :key="link.title"
            router
            :to="{ name: link.route }"
            class="tile"
          >
            <v-list-item-icon class="mr-2">
              <v-icon class="ml-4">
                {{ link.icon }}
              </v-icon>
            </v-list-item-icon>

            <v-list-item-content>
              <v-list-item-title>
                {{ link.title }}
              </v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list-group>
      </v-list>
      <v-divider />
      <template #append>
        <div class="px-5 py-1">
          <v-btn rounded text class="text-lowercase">v0.5.0</v-btn>
          <v-btn icon class="float-right">
            <v-icon>{{ $vuetify.icons.values.helpCircleOutline }}</v-icon>
          </v-btn>
        </div>
      </template>
    </v-navigation-drawer>
  </div>
</template>

<script>
// import Logo from "@/assets/images/isologotipo_b_positivo";

export default {
  name: "SideNav",
  components: {},
  props: {
    drawer: {
      type: Boolean,
      required: true,
    },
  },
  data() {
    return {
      // Logo,
      isOpen: null,
      links: [
        {
          icon: this.$vuetify.icons.values.account,
          title: this.$t("views.menu.exercises"),
          route: "admin-exercises",
          if: this.$can("index", "Exercise"),
        },
      ],
      adminLinks: [
        {
          icon: this.$vuetify.icons.values.account,
          title: this.$t("views.menu.users"),
          route: "admin-users",
          if: this.$can("index", "User"),
        },
        {
          icon: this.$vuetify.icons.values.accountGroup,
          title: this.$t("views.menu.groups"),
          route: "admin-groups",
          if: this.$can("index", "Group"),
        },
      ],
      title: this.$t("views.app.title"),
    };
  },
  computed: {
    visibleLinks() {
      return this.links.filter((item) => item.if);
    },
    visibleAdminLinks() {
      return this.adminLinks.filter((item) => item.if);
    },
  },
  watch: {
    drawer() {
      this.isOpen = !this.isOpen;
    },
  },
};
</script>

<style scoped>
.v-expansion-panel-content > .v-expansion-panel-content__wrap {
  padding: 0px;
}

.v-application .primary--text {
  color: inherit !important;
  background: inherit;
}
</style>
