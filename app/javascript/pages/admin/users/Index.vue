<template>
  <div>
    <portal to="search-input">
      <SearchInput
        route="admin-users"
        :placeholder="$t('views.users.index.search')"
        search-param="usernameCont"
        :filters="$store.state.filters.adminUsers"
      />
    </portal>

    <h1 class="pb-4">
      {{ $t("views.users.index.title") }}
    </h1>

    <v-row no-gutters>
      <SkeletonSuspense :object="users">
        <UsersTable :users="users" />
      </SkeletonSuspense>
    </v-row>
  </div>
</template>

<script>
import UsersTable from "@/components/admin/users/UsersTable";
import UserResource from "@/resources/User";

export default {
  components: {
    UsersTable
  },
  data: () => {
    return {
      users: null
    };
  },
  watch: {
    $route: "loadUsers"
  },
  created() {
    this.loadUsers();
  },
  mounted() {
    this.$bus.$on("update:resource", () => this.loadUsers());
  },
  beforeDestroy() {
    this.$bus.$off("update:resource");
  },
  methods: {
    async loadUsers() {
      this.$store.dispatch("filters/add", {
        key: "adminUsers",
        filters: this.$route.query
      });

      this.users = await UserResource.list(
        this.$store.state.filters.adminUsers
      );
    }
  }
};
</script>
