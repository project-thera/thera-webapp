<template>
  <fragment>
    <v-card
      v-for="routine in patient.routines().target().__collection"
      :key="routine.id"
      elevation="2"
      class="ma-4 pa-4"
    >
      <v-card-title>Rutina #{{ routine.id }}</v-card-title>
      <v-card-subtitle>Creada el {{ routine.created_at }} </v-card-subtitle>

      <v-card-text>
        <VueHorizontal responsive class="ma-4">
          <v-card
            v-for="exercise in routine.exercises().target().__collection"
            :key="exercise.id"
            elevation="2"
            class="ma-4"
          >
            <v-card-title>{{ exercise.name }}</v-card-title>
            <v-card-subtitle>Repeticiones {{ 1 }}</v-card-subtitle>
          </v-card>
        </VueHorizontal>
      </v-card-text>
      <v-card-actions>
        <v-btn color="primary">
          Ver
        </v-btn>

        <v-btn color="primary">
          Finalizar
        </v-btn>

        <v-btn>
          Borrar
        </v-btn>
      </v-card-actions>
    </v-card>
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
