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
                  :label="$t('attributes.routine.name')"
                  :error-messages="errors"
                />
              </ValidationProvider>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="12" md="6">
              <ValidationProvider
                v-slot="{ errors }"
                rules="required|min_value:1|integer"
                vid="dailyLimit"
              >
                <v-text-field
                  v-model="object.dailyLimit"
                  type="number"
                  :label="$t('attributes.routine.dailyLimit')"
                  :error-messages="errors"
                />
              </ValidationProvider>
            </v-col>
          </v-row>
          <v-row no-gutters>
            <v-col cols="12" md="6" class="d-flex">
              <h3 class="mb-2 pr-4">
                {{ $t("attributes.routine.routineExercises") }}
              </h3>

              <v-btn
                color="success"
                small
                tile
                elevation="0"
                @click="addRoutineExercise"
              >
                <v-icon left small>{{ $vuetify.icons.values.plus }}</v-icon
                >{{ $t("views.patients.addRoutineForm.addRoutineExercise") }}
              </v-btn>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="12" md="6">
              <div
                v-for="(routineExercise, index) in routineExercisesAttributes"
                :key="index"
                class="form-row"
              >
                <div v-if="routineExercise._destroy != 1" class="mb-2">
                  <RoutineExerciseForm
                    :attributes="routineExercisesAttributes[index]"
                    :exercises="exercises"
                  >
                    <v-tooltip bottom>
                      <template #activator="{ on, attrs }">
                        <v-btn
                          class="ma-4"
                          icon
                          v-bind="attrs"
                          v-on="on"
                          @click="removeRoutineExercise(index)"
                        >
                          <v-icon color="dark-grey">{{
                            $vuetify.icons.values.delete
                          }}</v-icon>
                        </v-btn>
                      </template>
                      <span>{{
                        $t(
                          "views.patients.addRoutineForm.removeRoutineExercise"
                        )
                      }}</span>
                    </v-tooltip>
                  </RoutineExerciseForm>
                </div>
              </div>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="12">
              <SaveButton />
              <DiscardButton to="/admin/usuarios" />
            </v-col>
          </v-row>
        </v-container>
      </v-form>
    </ValidationObserver>
  </div>
</template>

<script>
import Vue from "vue";
import RoutineExerciseForm from "./RoutineExerciseForm";

import User from "@/resources/User";
import Exercise from "@/resources/Exercise";
import Routine from "@/resources/Routine";
import RoutineExercise from "@/resources/RoutineExercise";

export default {
  components: {
    RoutineExerciseForm
  },
  props: {
    patient: {
      type: User,
      required: true
    }
  },
  data: ({ patient }) => {
    const routine = Routine.build({
      supervisorId: `${patient.supervisorId}`,
      patientId: patient.id
    });

    return {
      routine,
      object: { ...{ dailyLimit: 1 }, ...routine.attributes() },
      routineExercisesAttributes: Object.assign(
        [
          Object.assign(
            { _destroy: 0 },
            RoutineExercise.build({ repetitions: 1 }).attributes()
          )
        ],
        routine.routineExercisesAttributes
      ),
      exercises: []
    };
  },
  created() {
    this.loadExercises();
  },
  methods: {
    addRoutineExercise() {
      this.routineExercisesAttributes.push(
        Object.assign(
          { _destroy: 0 },
          RoutineExercise.build({ repetitions: 1 }).attributes()
        )
      );
    },
    removeRoutineExercise(index) {
      Vue.set(this.routineExercisesAttributes[index], "_destroy", 1);
    },
    // TODO move to ajax request
    async loadExercises() {
      const exercises = await Exercise.perPage(50).all();
      this.exercises = exercises.toArray();
    },
    async onSubmit() {
      this.loading = true;
      if (this.$refs.form.validate()) {
        this.routine.assignAttributes({
          ...this.object,
          routineExercisesAttributes: this.routineExercisesAttributes
          // state: 'draft',
        });
        try {
          await this.routine.save();

          this.loading = false;

          this.$router.push({
            name: "admin-patients-show",
            params: { id: this.patient.id },
            query: { tab: "Rutinas Activas" }
          });

          this.$toasted.success(
            this.$t("views.routines.create.notice", {
              routine: this.routine.toString()
            })
          );
        } catch {
          this.loading = false;
          this.$refs.form.setErrors(this.routine.getErrors());
        }
      }
    }
  }
};
</script>
