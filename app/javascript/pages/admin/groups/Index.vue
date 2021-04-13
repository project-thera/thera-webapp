<template>
  <div>
    <portal to="search-input">
      <SearchInput
        route="admin-groups"
        :placeholder="$t('views.groups.index.search')"
        search-param="nameCont"
        :filters="$store.state.filters.adminGroups"
      />
    </portal>

    <h1 class="pb-4">
      {{ $t("views.groups.index.title") }}
    </h1>

    <v-row no-gutters>
      <Suspense :object="groups">
        <GroupsTable :groups="groups" />
      </Suspense>
    </v-row>
  </div>
</template>

<script>
import GroupsTable from "@/components/admin/groups/GroupsTable";
import GroupResource from "@/resources/Group";

export default {
  components: {
    GroupsTable
  },
  data: () => {
    return {
      groups: null
    };
  },
  watch: {
    $route: "loadGroups"
  },
  created() {
    this.loadGroups();
  },
  mounted() {
    this.$bus.$on("update:resource", () => this.loadGroups());
  },
  beforeDestroy() {
    this.$bus.$off("update:resource");
  },
  methods: {
    async loadGroups() {
      const query = this.$route.query;

      this.$store.dispatch("filters/add", {
        key: "adminGroups",
        filters: query
      });

      this.groups = await GroupResource.list(
        this.$store.state.filters.adminGroups
      );
    }
  }
};
</script>
