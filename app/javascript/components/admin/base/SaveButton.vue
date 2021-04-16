<template>
  <v-btn tile class="mr-4" color="success" :loading="loading" type="submit">
    {{ $t("views.actions.save") }}
  </v-btn>
</template>

<script>
export default {
  props: {
    loading: {
      type: Boolean,
      default: false
    }
  }
};
</script>
