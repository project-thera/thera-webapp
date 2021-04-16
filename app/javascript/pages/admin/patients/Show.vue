<template>
  <Suspense :object="patient">
    <div v-if="patient">
      <h1 class="mb-8">Paciente {{ patient.fullname }}</h1>

      <v-btn
        v-if="$can('addRoutine', patient)"
        dark
        color="primary"
        :text="false"
        :title="$t('views.actions.addRoutine')"
        @click.stop="
          $router.push({
            name: 'admin-patients-add-routine',
            params: { id: patient.id }
          })
        "
      >
        <v-icon>{{ $vuetify.icons.values.plus }}</v-icon>
        Agregar Rutina
      </v-btn>

      <ShowTabs :patient="patient" />
    </div>
  </Suspense>
</template>

<script>
import User from "@/resources/User";
import ShowTabs from "@/components/admin/patients/ShowTabs";

export default {
  components: {
    ShowTabs
  },
  data() {
    return {
      patient: null
    };
  },
  created() {
    User.find(this.$route.params.id) // .includes({ routines: { routineExercises: ["exercise"] } })
      .then(patient => {
        this.patient = patient;
      });
  }
};
</script>
