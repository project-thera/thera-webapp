<template>
  <fragment>
    <p>Rutinas anteriores</p>
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
  data() {
    return {};
  }
};
</script>
