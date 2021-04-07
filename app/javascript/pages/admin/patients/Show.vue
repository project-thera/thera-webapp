<template>
  <div v-if="patient">
    <h2>Paciente {{ patient.fullname }}</h2>
  </div>
</template>

<script>
import User from "@/resources/User";
import Form from "@/components/admin/users/Form";

export default {
  components: {
    Form,
  },
  data() {
    return {
      patient: null,
    };
  },
  created() {
    User.find(this.$route.params.id)
      .then((patient) => {
        this.patient = patient;
      });
  },
};
</script>
