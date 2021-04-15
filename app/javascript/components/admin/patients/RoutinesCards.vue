<template>
  <div>
    <LoadingIcon v-if="loading" />
    <v-container v-else>
      <v-row>
        <v-col
          v-for="routine in routines"
          :key="routine.id"
          cols="12"
          sm="12"
          md="3"
        >
          <v-hover v-slot="{ hover }">
            <v-card
              :elevation="hover ? 8 : 2"
              :class="{ 'on-hover': hover }"
              class="ma-4 pa-4"
            >
              <v-card-title>{{ routine.toString() }}</v-card-title>
              <v-card-subtitle
                >Creada
                {{ $minifyUpdatedAt(routine.createdAt) }}</v-card-subtitle
              >
              <v-list>
                <v-list-item
                  v-for="routineExercise in routine
                    .routineExercises()
                    .toArray()"
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
              <RoutineCardActions :routine="routine" />
            </v-card>
          </v-hover>
        </v-col>
      </v-row>

      <v-row v-if="routines.length == 0">
        <p>El paciente no tiene rutinas</p>
      </v-row>

      <v-row>
        <v-btn
          v-if="$can('addRoutine', patient)"
          class="mt-2"
          color="primary"
          :title="$t('views.actions.addRoutine')"
          @click.stop="
            $router.push({
              name: 'admin-patients-add-routine',
              params: { id: patient.id }
            })
          "
        >
          Agregar Rutina
        </v-btn>
      </v-row>

      <div>
        <v-pagination v-model="page" :length="pageCount" @input="paginate" />
      </div>
    </v-container>
  </div>
</template>

<script>
import User from "@/resources/User";
import RoutineCardActions from "./RoutineCardActions";

export default {
  components: {
    RoutineCardActions
  },
  props: {
    patient: {
      type: User,
      required: true
    },
    loadRoutines: {
      type: Function,
      required: true
    },
    perPage: {
      type: Number,
      required: true
    },
    pageCount: {
      type: Number,
      required: true
    },
    routines: {
      type: Array,
      required: true
    },
    loading: {
      type: Boolean,
      required: true
    }
  },
  data() {
    return {
      console: console,
      page: 1
    };
  },
  mounted() {
    this.$bus.$on("update:resource", () => this.loadRoutines(this.page));
  },
  beforeDestroy() {
    this.$bus.$off("update:resource");
  },
  async created() {
    this.loadRoutines(this.page);
  },
  methods: {
    paginate(pageNumber) {
      this.page = pageNumber;

      this.loadRoutines(pageNumber);
    }
  }
};
</script>
