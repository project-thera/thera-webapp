<template>
  <div>
    <ValidationObserver ref="form" v-slot="{ handleSubmit }">
      <v-form @submit.prevent="handleSubmit(onSubmit)">
        <v-container fluid>
          <v-row>
            <v-col cols="12" md="6">
              <ValidationProvider
                v-slot="{ errors }"
                rules="required"
                vid="name"
              >
                <v-text-field
                  v-model="object.name"
                  :label="$t('attributes.exercise.name')"
                  :error-messages="errors"
                />
              </ValidationProvider>
            </v-col>

            <v-col cols="12" md="6">
              <ValidationProvider
                v-slot="{ errors }"
                rules="required"
                vid="name"
              >
                <v-select
                  v-model="object.klassName"
                  :items="exerciseTypes"
                  :label="$t('attributes.exercise.klassName')"
                  :error-messages="errors"
                  @change="resetExerciseSteps"
                />
              </ValidationProvider>
            </v-col>
          </v-row>

          <v-row>
            <v-col cols="12">
              <h3 class="mb-2 pr-2 text-uppercase">
                {{ $t("attributes.exercise.exerciseSteps") }}
              </h3>
            </v-col>
            <v-col cols="auto">
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

              <div
                v-for="(exerciseStep, index) in exerciseStepsAttributes"
                :key="index"
                class="form-row"
              >
                <ExerciseStepForm
                  :attributes="exerciseStepsAttributes[index]"
                  :goals="goals"
                >
                  <v-tooltip bottom>
                    <template #activator="{ on, attrs }">
                      <v-btn
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
        </v-container>
      </v-form>
    </ValidationObserver>
  </div>
</template>

<script>
import ExerciseStepForm from "./ExerciseStepForm";
import Exercise from "@/resources/Exercise";

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
  data: ({ exercise }) => {
    return {
      object: exercise.attributes(),
      exerciseTypes: [
        "Reconocimiento facial",
        "Soplido",
        "Reconocimiento de voz"
      ],
      exerciseStepsAttributes: [], // JSON.parse(exercise.steps)
      goals: []
    };
  },
  methods: {
    resetExerciseSteps() {
      this.exerciseStepsAttributes = [];
    },
    addExerciseStep() {
      this.exerciseStepsAttributes.push({ goal: null, time: 1000 });
    },
    removeExerciseStep(index) {
      this.exerciseStepsAttributes.splice(index, index);
    },
    async loadGoals() {
      // const exercises = await Exercise.perPage(50).all();
      // this.exercises = exercises.toArray();
    },
    async onSubmit() {
      this.loading = true;
      if (this.$refs.form.validate()) {
        this.exercise.assignAttributes({
          ...this.object
          //routineExercisesAttributes: this.routineExercisesAttributes
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
