<template>
  <v-container fluid>
    <LoadingIcon v-if="object == null" />
    <slot v-else />
  </v-container>
</template>

<script>
export default {
  props: {
    object: {
      type: [Array, Object],
      default: null
    }
  }
};
</script>
