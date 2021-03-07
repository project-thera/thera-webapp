<template>
  <v-btn tile color="success" :to="to">
    <v-icon left>{{ $vuetify.icons.values.plus }}</v-icon
    >{{ text }}
  </v-btn>
</template>

<script>
export default {
  props: {
    to: {
      type: Object,
      required: true,
    },
    text: {
      type: String,
      required: true,
    },
  },
};
</script>
