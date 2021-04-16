<template>
  <v-hover v-slot="{ hover }">
    <v-card
      :elevation="hover ? 8 : 2"
      :class="{ 'on-hover': hover }"
      class="ma-4 pa-4"
      height="100%"
    >
      <v-container fluid fill-height class="d-flex flex-column align-start">
        <div class="mb-auto">
          <v-card-title>{{ routine.toString() }}</v-card-title>
          <v-card-subtitle
            >Creada {{ $minifyUpdatedAt(routine.createdAt) }}</v-card-subtitle
          >
          <v-list class="mb-auto">
            <v-list-item
              v-for="routineExercise in routine.routineExercises().toArray()"
              :key="routineExercise.id"
              :style="{ minHeight: '28px' }"
            >
              <v-list-item-content class="pa-0">
                <v-list-item-title
                  >{{ routineExercise.exercise().name }} ({{
                    routineExercise.repetitions
                  }})</v-list-item-title
                >
              </v-list-item-content>
            </v-list-item>
          </v-list>
        </div>
        <div>
          <RoutineCardActions :routine="routine" />
        </div>
      </v-container>
    </v-card>
  </v-hover>
</template>

<script>
import Routine from "@/resources/Routine";
import RoutineCardActions from "./RoutineCardActions";

export default {
  components: {
    RoutineCardActions
  },
  props: {
    routine: {
      type: Routine,
      required: true
    }
  }
};
</script>
