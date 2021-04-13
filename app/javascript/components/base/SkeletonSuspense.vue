<template>
  <v-container fluid>
    <v-skeleton-loader v-if="object == null" :type="type" />
    <slot v-else />
  </v-container>
</template>

<script>
export default {
  props: {
    object: {
      type: [Array, Object],
      default: null
    },
    type: {
      type: String,
      default: "table"
    }
  }
};
</script>
