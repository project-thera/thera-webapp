<template>
  <div v-if="patient">
    <h2>Paciente {{ patient.fullname }}</h2>
    <Tabs :patient="patient" />
  </div>
</template>

<script>
import User from "@/resources/User";
import Tabs from "@/components/admin/patients/Tabs";

export default {
  components: {
    Tabs,
  },
  data() {
    return {
      patient: null,
    };
  },
  created() {
    User.includes({ routines: ['exercises'] })
      .find(this.$route.params.id)
      .then((patient) => {
        this.patient = patient;
      });
  },
};
</script>
