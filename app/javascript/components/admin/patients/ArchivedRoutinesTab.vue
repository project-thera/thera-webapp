<template>
  <RoutinesCards
    :load-routines="loadRoutines"
    v-bind="$data"
    :patient="patient"
    :loading="loading"
  />
</template>

<script>
import User from "@/resources/User";
import RoutinesCards from "./RoutinesCards";

export default {
  components: {
    RoutinesCards
  },
  props: {
    patient: {
      type: User,
      required: true
    }
  },
  data() {
    return {
      routines: [],
      perPage: 4,
      pageCount: 1,
      loading: true
    };
  },
  methods: {
    async loadRoutines(pageNumber) {
      this.loading = true;

      const routineCollection = await this.patient
        .routines()
        .includes({ routineExercises: ["exercise"] })
        .where({ discarded: true })
        .page(pageNumber)
        .perPage(this.perPage)
        .all();

      this.routines = routineCollection.toArray();
      this.pageCount = Math.ceil(
        routineCollection.meta().recordCount / this.perPage
      );

      this.loading = false;
    }
  }
};
</script>
