<template>
  <fragment>
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
            <v-card-title>Rutina #{{ routine.id }}</v-card-title>
            <v-card-subtitle
              >Creada {{ $minifyUpdatedAt(routine.createdAt) }}</v-card-subtitle
            >
            <v-list>
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
            <v-card-actions>
              <v-btn
                v-if="$can('show', routine)"
                icon
                :title="$t('views.actions.show')"
                @click.stop="
                  $router.push({
                    name: 'admin-routines-show',
                    params: { id: routine.id }
                  })
                "
              >
                <v-icon big>{{ $vuetify.icons.values.eye }}</v-icon>
              </v-btn>

              <v-btn icon>
                <v-icon medium>{{
                  $vuetify.icons.values.archiveArrowDown
                }}</v-icon>
              </v-btn>

              <v-btn icon>
                <v-icon medium>{{ $vuetify.icons.values.delete }}</v-icon>
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-hover>
      </v-col>
    </v-row>
    <v-btn
      v-if="$can('addRoutine', patient)"
      color="primary"
      :title="$t('views.actions.edit')"
      @click.stop="
        $router.push({
          name: 'admin-patients-add-routine',
          params: { id: patient.id }
        })
      "
    >
      Agregar Rutina
    </v-btn>

    <div class="text-center">
      <v-pagination v-model="page" :length="pageCount" @input="paginate" />
    </div>
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

    return {
      routines: [],
      page: 1,
      perPage: 4,
      pageCount: 1
    };
  },
  async created() {
    this.loadRoutines(this.page);
  },
  methods: {
    paginate(pageNumber) {
      this.loadRoutines(pageNumber);
    },
    async loadRoutines(pageNumber) {
      const routineCollection = await this.patient
        .routines()
        .includes({ routineExercises: ["exercise"] })
        .page(pageNumber)
        .perPage(this.perPage)
        .all();

      this.routines = routineCollection.toArray();
      this.pageCount = Math.ceil(
        routineCollection.meta().recordCount / this.perPage
      );
    }
  }
};
</script>
