<template>
  <Suspense :object="patient">
    <div v-if="patient">
      <h1>Paciente {{ patient.fullname }}</h1>
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
