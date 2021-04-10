<template>
  <fragment>
    <v-card class="d-flex pa-4" outlined tile>
      <v-row>
        <v-col cols="12" md="8">
          <ValidationProvider v-slot="{ errors }" rules="required" vid="goal">
            <v-select
              v-model="attributes.goal"
              :items="goals"
              :label="$t('attributes.exerciseStep.goal')"
              item-value="id"
              :error-messages="errors"
            />
          </ValidationProvider>
        </v-col>

        <v-col cols="12" md="4">
          <ValidationProvider
            v-slot="{ errors }"
            rules="required|min_value:1000|integer"
            vid="time"
          >
            <v-text-field
              v-model="attributes.time"
              type="number"
              :label="$t('attributes.exerciseStep.time')"
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
    goals: {
      type: Array,
      default: () => []
    }
  }
};
</script>
