<template>
  <fragment>
    <v-card class="d-flex pa-4 ma-2" outlined>
      <v-row>
        <v-col v-if="fields.includes('goal')" cols="12" md="6">
          <template v-if="goals">
            <ValidationProvider v-slot="{ errors }" rules="required" vid="goal">
              <v-select
                v-model="attributes.goal"
                :items="goals"
                :label="$t('attributes.exerciseStep.goal')"
                :error-messages="errors"
              />
            </ValidationProvider>
          </template>
          <template v-else>
            <ValidationProvider v-slot="{ errors }" rules="required" vid="goal">
              <v-text-field
                v-model="attributes.goal"
                :label="$t('attributes.exerciseStep.goal')"
                :error-messages="errors"
              />
            </ValidationProvider>
          </template>
        </v-col>

        <v-col v-if="fields.includes('time')" cols="12" md="6">
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

        <v-col v-if="fields.includes('image')" cols="12" md="6">
          <ValidationProvider
            v-slot="{ validate, errors }"
            :rules="`mimes:${mimes}|size:40`"
            vid="image"
          >
            <v-row>
              <v-col cols="8">
                <v-file-input
                  :accept="mimes"
                  :label="$t('attributes.exerciseStep.image')"
                  :error-messages="errors"
                  @change="
                    file => {
                      $setFileData(file, attributes, 'image', validate);
                    }
                  "
                />
              </v-col>
              <v-col cols="4">
                <template v-if="attributes.image">
                  <img style="height: 50px" :src="attributes.image" />
                </template>
              </v-col>
            </v-row>
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
    },
    fields: {
      type: Array,
      required: true
    }
  },
  data: () => {
    return {
      mimes: "image/png,image/jpeg,image/jpg",
      console: console
    };
  }
};
</script>
