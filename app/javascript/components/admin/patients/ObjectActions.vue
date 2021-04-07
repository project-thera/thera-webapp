<template>
  <div>
    <v-btn
      v-if="$can('show', patient)"
      icon
      :title="$t('views.actions.show')"
      @click.stop="
        $router.push({ name: 'admin-patients-show', params: { id: user.id } })
      "
    >
      <v-icon medium>{{ $vuetify.icons.values.eye }}</v-icon>
    </v-btn>
  </div>
</template>

<script>
export default {
  props: {
    patient: {
      type: Object,
      required: true,
    },
  },
};
</script>

<style lang="sass" scoped></style>
