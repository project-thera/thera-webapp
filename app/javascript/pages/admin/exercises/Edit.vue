<template>
  <div v-if="exercise">
    <h2>Editar ejercicio {{ exercise }}</h2>
    <Form :exercise="exercise" />
  </div>
</template>

<script>
import Exercise from "@/resources/Exercise";
import Form from "@/components/admin/exercises/Form";

export default {
  components: {
    Form
  },
  data() {
    return {
      exercise: null
    };
  },
  created() {
    Exercise.find(this.$route.params.id).then(exercise => {
      this.exercise = exercise;
    });
  }
};
</script>
