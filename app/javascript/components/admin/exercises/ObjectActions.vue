<template>
  <div>
    <v-btn
      v-if="$can('update', exercise)"
      icon
      :title="$t('views.actions.edit')"
      @click.stop="
        $router.push({ name: 'admin-exercises-edit', params: { id: exercise.id } })
      "
    >
      <v-icon medium>{{ $vuetify.icons.values.pencil }}</v-icon>
    </v-btn>

    <ResourceActionButton
      v-if="$can('discard', exercise)"
      :resource="exercise"
      :title="$t('views.actions.discard')"
      :message="$t('views.exercises.discard.notice', { exercise: exercise.name })"
      action="discard"
    >
      <v-icon>{{ $vuetify.icons.values.delete }}</v-icon>
    </ResourceActionButton>

    <ResourceActionButton
      v-if="$can('undiscard', exercise)"
      :resource="exercise"
      :title="$t('views.actions.undiscard')"
      :message="$t('views.exercise.undiscard.notice', { exercise: exercise.name })"
      action="undiscard"
    >
      <v-icon>{{ $vuetify.icons.values.deleteRestore }}</v-icon>
    </ResourceActionButton>

    <ResourceActionButton
      v-if="$can('destroy', exercise)"
      :resource="exercise"
      :title="$t('views.actions.destroy')"
      :message="$t('views.exercises.destroy.notice', { exercise: exercise.name })"
      action="destroy"
    >
      <v-icon>{{ $vuetify.icons.values.deleteForever }}</v-icon>
    </ResourceActionButton>
  </div>
</template>

<script>
export default {
  props: {
    exercise: {
      type: Object,
      required: true,
    },
  },
};
</script>

<style lang="sass" scoped></style>
