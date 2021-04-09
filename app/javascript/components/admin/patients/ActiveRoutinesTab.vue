<template>
  <RoutinesCards
    :load-routines="loadRoutines"
    v-bind="$data"
    :patient="patient"
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
      pageCount: 1
    };
  },
  methods: {
    async loadRoutines(pageNumber) {
      const routineCollection = await this.patient
        .routines()
        .includes({ routineExercises: ["exercise"] })
        .where({ discarded: false })
        .page(pageNumber)
        .perPage(this.perPage)
        .all();

      this.routines = routineCollection.toArray();
      this.pageCount = Math.ceil(
        routineCollection.meta().recordCount / this.perPage
      );
    }
  }
};
</script>
