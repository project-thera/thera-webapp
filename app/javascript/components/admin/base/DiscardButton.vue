<template>
  <!-- FIXME -->
  <v-btn tile text @click="$router.back()" title="Cancelar">
    Cancelar
  </v-btn>
</template>

<script>
export default {
  props: {
    to: {
      type: [String, Object],
      required: true,
    },
  },
};
</script>
