<template>
  <fragment>
    <p>Rutinas activas</p>
    <VueHorizontal responsive>
      <section
        v-for="exercice in patient
          .routines()
          .target()
          .first()
          .exercises()
          .target().__collection"
        :key="exercice.id"
      >
        <h3>{{ exercice.name }}</h3>
        <p>{{ exercice.name }}</p>
      </section>
    </VueHorizontal>
  </fragment>
</template>

<script>
import User from "@/resources/User";

export default {
  props: {
    patient: {
      type: User,
      required: true
    }
  },
  data({ patient }) {
    console.log(patient);
    return {};
  }
};
</script>
