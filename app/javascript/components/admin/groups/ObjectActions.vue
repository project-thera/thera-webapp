<template>
  <div>
    <v-btn
      v-if="$can('update', group)"
      icon
      :to="{ name: 'admin-groups-edit', params: { id: group.id } }"
      :title="$t('views.actions.edit')"
    >
      <v-icon>{{ $vuetify.icons.values.pencil }}</v-icon>
    </v-btn>

    <ResourceActionButton
      v-if="$can('discard', group)"
      :resource="group"
      :title="$t('views.actions.discard')"
      :message="$t('views.groups.discard.notice', { group: group.name })"
      action="discard"
    >
      <v-icon>{{ $vuetify.icons.values.deleteOutline }}</v-icon>
    </ResourceActionButton>

    <ResourceActionButton
      v-if="$can('undiscard', group)"
      :resource="group"
      :title="$t('views.actions.undiscard')"
      :message="$t('views.groups.undiscard.notice', { group: group.name })"
      action="undiscard"
    >
      <v-icon>{{ $vuetify.icons.values.deleteRestore }}</v-icon>
    </ResourceActionButton>

    <ResourceActionButton
      v-if="$can('destroy', group)"
      :resource="group"
      :title="$t('views.actions.destroy')"
      :message="$t('views.actions.destroy')"
      action="destroy"
    >
      <v-icon>{{ $vuetify.icons.values.deleteForeverOutline }}</v-icon>
    </ResourceActionButton>
  </div>
</template>

<script>
export default {
  props: {
    group: {
      type: Object,
      required: true,
    },
  },
};
</script>

<style lang="scss" scoped></style>
