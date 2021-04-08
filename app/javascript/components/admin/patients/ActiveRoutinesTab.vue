<template>
  <fragment>
    <v-row>
      <v-col
        v-for="routine in patient
          .routines()
          .target()
          .toArray()"
        :key="routine.id"
        cols="12"
        sm="3"
        md="4"
      >
        <v-card elevation="2" class="ma-4 pa-4">
          <v-row>
            <v-col cols="4">
              <v-card-title>Rutina #{{ routine.id }}</v-card-title>
              <v-card-subtitle
                >Creada el {{ routine.created_at }}</v-card-subtitle
              >
            </v-col>
            <v-col cols="8">
              <v-list>
                <v-list-item
                  v-for="routineExercise in routine
                    .routineExercises()
                    .toArray()"
                  :key="routineExercise.id"
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
            </v-col>
          </v-row>
          <v-card-actions>
            <v-btn color="primary">
              Ver
            </v-btn>

            <v-btn color="primary">
              Finalizar
            </v-btn>

            <v-btn text>
              Borrar
            </v-btn>
          </v-card-actions>
        </v-card>
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
  }
};
</script>
