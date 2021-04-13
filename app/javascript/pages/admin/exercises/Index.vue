<template>
  <div>
    <portal to="search-input">
      <SearchInput
        route="admin-exercises"
        :placeholder="$t('views.exercises.index.search')"
        search-param="nameCont"
        :filters="$store.state.filters.adminExercises"
      />
    </portal>

    <h1 class="pb-4">
      {{ $t("views.exercises.index.title") }}
    </h1>

    <v-row no-gutters>
      <SkeletonSuspense :object="exercises">
        <ExercisesTable :exercises="exercises" />
      </SkeletonSuspense>
    </v-row>
  </div>
</template>

<script>
import ExercisesTable from "@/components/admin/exercises/ExercisesTable";
import ExerciseResource from "@/resources/Exercise";

export default {
  components: {
    ExercisesTable
  },
  data: () => {
    return {
      exercises: null
    };
  },
  watch: {
    $route: "loadExercises"
  },
  created() {
    this.loadExercises();
  },
  mounted() {
    this.$bus.$on("update:resource", () => this.loadExercises());
  },
  beforeDestroy() {
    this.$bus.$off("update:resource");
  },
  methods: {
    async loadExercises() {
      this.$store.dispatch("filters/add", {
        key: "adminExercises",
        filters: this.$route.query
      });

      this.exercises = await ExerciseResource.list(
        this.$store.state.filters.adminExercises
      );
    }
  }
};
</script>
