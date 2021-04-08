<template>
  <div>
    <portal to="search-input">
      <SearchInput
        route="admin-patients"
        :placeholder="$t('views.users.index.search')"
        search-param="usernameCont"
        :filters="$store.state.filters.adminPatients"
      />
    </portal>

    <h1 class="text-uppercase pb-4">
      {{ $t("views.patients.index.title") }}
    </h1>

    <v-row no-gutters>
      <Suspense :object="patients">
        <PatientsTable :patients="patients" />
      </Suspense>
    </v-row>
  </div>
</template>

<script>
import PatientsTable from "@/components/admin/patients/PatientsTable";
import UserResource from "@/resources/User";

export default {
  components: {
    PatientsTable
  },
  data: () => {
    return {
      patients: null
    };
  },
  watch: {
    $route: "loadPatients"
  },
  created() {
    this.loadPatients();
  },
  mounted() {
    this.$bus.$on("update:resource", () => this.loadPatients());
  },
  beforeDestroy() {
    this.$bus.$off("update:resource");
  },
  methods: {
    async loadPatients() {
      this.$store.dispatch("filters/add", {
        key: "adminPatients",
        filters: this.$route.query
      });

      this.patients = await UserResource.listPatients(
        this.$store.state.filters.adminPatients
      );
    }
  }
};
</script>
