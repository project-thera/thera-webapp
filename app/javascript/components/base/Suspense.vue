<template>
  <div>
    <LoadingIcon v-if="object == null" />
    <slot v-else />
  </div>
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
