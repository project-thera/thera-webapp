<template>
  <Suspense :object="patient">
    <h1>Agregar Rutina</h1>
    <AddRoutineForm :patient="patient" />
  </Suspense>
</template>

<script>
import AddRoutineForm from "@/components/admin/patients/AddRoutineForm";
import User from "@/resources/User";

export default {
  components: {
    AddRoutineForm
  },
  data() {
    return {
      patient: null
    };
  },
  created() {
    User.includes({ routines: ["exercises"] })
      .find(this.$route.params.id)
      .then(patient => {
        this.patient = patient;
      });
  }
};
</script>
