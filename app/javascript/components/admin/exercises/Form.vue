<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit }">
    <v-form @submit.prevent="handleSubmit(onSubmit)">
      <v-container fluid>
        <v-row>
          <v-col cols="12" md="6">
            <ValidationProvider
              v-slot="{ errors }"
              rules="required"
              vid="exerciseType"
            >
              <v-btn-toggle
                v-for="exerciseType in exerciseTypeOptions"
                :key="exerciseType.value"
                v-model="object.exerciseType"
                :error-messages="errors"
                @change="resetExerciseSteps"
              >
                <v-btn :value="exerciseType.value">
                  <span>{{ exerciseType.text }}</span>
                  <v-icon right>
                    {{ exerciseTypeIcon[exerciseType.value] }}
                  </v-icon>
                </v-btn>
              </v-btn-toggle>
              <div class="v-messages theme--light error--text" role="alert">
                <div class="v-messages__wrapper">
                  <div class="v-messages__message">
                    {{ errors[0] }}
                  </div>
                </div>
              </div>
            </ValidationProvider>
          </v-col>
        </v-row>

        <v-row>
          <v-col cols="12" md="6">
            <ValidationProvider v-slot="{ errors }" rules="required" vid="name">
              <v-text-field
                v-model="object.name"
                :label="$t('attributes.exercise.name')"
                :error-messages="errors"
              />
            </ValidationProvider>
          </v-col>
        </v-row>
        <!--
          <v-col cols="12" md="3">
            <ValidationProvider v-slot="{ errors }" rules="required" vid="exerciseType">
              <v-select
                v-model="object.exerciseType"
                :items="exerciseTypeOptions"
                :label="$t('attributes.exercise.exerciseType')"
                :error-messages="errors"
                @change="resetExerciseSteps"
              />
            </ValidationProvider>
          </v-col>
          -->
        <v-row>
          <v-col cols="12" md="6">
            <ValidationProvider
              v-slot="{ errors }"
              rules="required"
              vid="description"
            >
              <v-textarea
                v-model="object.description"
                :label="$t('attributes.exercise.description')"
                :error-messages="errors"
              />
            </ValidationProvider>
          </v-col>
        </v-row>

        <template v-if="object.exerciseType">
          <v-row>
            <v-col class="d-flex" cols="12" md="6">
              <h3 class="mb-2 pr-2">
                {{ $t("attributes.exercise.exerciseSteps") }}
              </h3>
              <v-btn
                color="success"
                small
                tile
                elevation="0"
                @click="addExerciseStep"
              >
                <v-icon left small>{{ $vuetify.icons.values.plus }}</v-icon
                >{{ $t("views.exercises.form.addExerciseStep") }}
              </v-btn>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="12" md="6">
              <div
                v-for="(exerciseStep, index) in exerciseStepsAttributes"
                :key="index"
                class="form-row"
              >
                <ExerciseStepForm
                  :attributes="exerciseStepsAttributes[index]"
                  :goals="goals"
                  :fields="stepFields"
                >
                  <v-tooltip bottom>
                    <template #activator="{ on, attrs }">
                      <v-btn
                        class="ma-4"
                        icon
                        v-bind="attrs"
                        v-on="on"
                        @click="removeExerciseStep(index)"
                      >
                        <v-icon color="dark-grey">{{
                          $vuetify.icons.values.delete
                        }}</v-icon>
                      </v-btn>
                    </template>
                    <span>{{
                      $t("views.exercises.form.removeExerciseStep")
                    }}</span>
                  </v-tooltip>
                </ExerciseStepForm>
              </div>
            </v-col>
          </v-row>
        </template>

        <v-row>
          <v-col cols="12">
            <SaveButton />
            <DiscardButton :to="{ name: 'admin-exercises' }" />
          </v-col>
        </v-row>
      </v-container>
    </v-form>
  </ValidationObserver>
</template>

<script>
import ExerciseStepForm from "./ExerciseStepForm";
import Exercise from "@/resources/Exercise";

import { exerciseTypeAndGoalsOptions } from "@/data/exercise-types";

export default {
  components: {
    ExerciseStepForm
  },
  props: {
    exercise: {
      type: Exercise,
      default: () => Exercise.build()
    }
  },
  data: instance => {
    const { exercise } = instance;
    const {
      exerciseTypeOptions,
      exerciseTypeGoalOptions,
      exerciseTypeStepFields
    } = exerciseTypeAndGoalsOptions(instance.$serverParameters);

    let exerciseStepsAttributes;
    let goals = null;
    let stepFields = [];

    try {
      exerciseStepsAttributes = JSON.parse(exercise.steps);
    } catch (e) {
      exerciseStepsAttributes = null;
    }

    if (!exerciseStepsAttributes) {
      exerciseStepsAttributes = [];
    }

    if (exercise.exerciseType) {
      goals = exerciseTypeGoalOptions[exercise.exerciseType];
      stepFields = exerciseTypeStepFields[exercise.exerciseType];
    }

    return {
      object: exercise.attributes(),
      // Current exercise
      stepFields,
      goals,
      exerciseStepsAttributes,
      // Exercise configuration
      exerciseTypeOptions,
      exerciseTypeGoalOptions,
      exerciseTypeStepFields,
      exerciseTypeIcon: {
        blow: instance.$vuetify.icons.values.weatherWindy,
        speech: instance.$vuetify.icons.values.microphone,
        classification: instance.$vuetify.icons.values.faceRecognition
      }
    };
  },
  methods: {
    defaultStep() {
      return { goal: null, time: 1000 };
    },
    resetExerciseSteps(value) {
      this.exerciseStepsAttributes = [this.defaultStep()];
      this.goals = this.exerciseTypeGoalOptions[value];
      this.stepFields = this.exerciseTypeStepFields[value];
    },
    addExerciseStep() {
      this.exerciseStepsAttributes.push(this.defaultStep());
    },
    removeExerciseStep(index) {
      this.exerciseStepsAttributes.splice(index, index);
    },
    async onSubmit() {
      this.loading = true;
      if (this.$refs.form.validate()) {
        this.exercise.assignAttributes({
          ...this.object,
          steps: JSON.stringify(this.exerciseStepsAttributes)
        });
        try {
          await this.exercise.save();

          this.loading = false;

          this.$router.push({
            name: "admin-exercises"
          });

          this.$toasted.success(
            this.$t("views.exercise.create.notice", {
              exercise: this.exercise.toString()
            })
          );
        } catch {
          this.loading = false;
          this.$refs.form.setErrors(this.exercise.getErrors());
        }
      }
    }
  }
};
</script>
