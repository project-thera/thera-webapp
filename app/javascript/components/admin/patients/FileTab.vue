<template>
  <fragment>
    <p>Ficha</p>
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
