<template>
  <!-- FIXME -->
  <v-btn tile text title="Cancelar" @click="$router.back()">
    {{ $t("views.actions.cancel") }}
  </v-btn>
</template>

<script>
export default {
  props: {
    to: {
      type: [String, Object],
      required: true
    }
  }
};
</script>
