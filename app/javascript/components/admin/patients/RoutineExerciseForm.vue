<template>
  <fragment>
    <v-card class="d-flex pa-4 ma-2" outlined tile>
      <v-row>
        <v-col cols="12" md="8">
          <ValidationProvider
            v-slot="{ errors }"
            rules="required"
            vid="routineExerciseDescription"
          >
            <v-select
              v-model="attributes.exerciseId"
              :items="exercises"
              :label="$t('attributes.routineExercise.exerciseId')"
              item-value="id"
              :error-messages="errors"
            />
          </ValidationProvider>
        </v-col>

        <v-col cols="12" md="4">
          <ValidationProvider
            v-slot="{ errors }"
            rules="required|min_value:1|integer"
            vid="repetitions"
          >
            <v-text-field
              v-model="attributes.repetitions"
              type="number"
              :label="$t('attributes.routineExercise.repetitions')"
              :error-messages="errors"
            />
          </ValidationProvider>
        </v-col>
      </v-row>
      <slot />
    </v-card>
  </fragment>
</template>

<script>
export default {
  props: {
    attributes: {
      type: Object,
      default: () => {}
    },
    exercises: {
      type: Array,
      default: () => []
    }
  }
};
</script>
