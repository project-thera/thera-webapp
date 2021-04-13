<template>
  <div v-if="exercise">
    <h1>Editar ejercicio {{ exercise }}</h1>
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
