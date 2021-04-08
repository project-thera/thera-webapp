<template>
  <div>
    <v-btn
      v-if="$can('update', exercise)"
      icon
      :title="$t('views.actions.edit')"
      @click.stop="
        $router.push({ name: 'admin-users-edit', params: { id: user.id } })
      "
    >
      <v-icon medium>{{ $vuetify.icons.values.pencil }}</v-icon>
    </v-btn>

    <ResourceActionButton
      v-if="$can('discard', user)"
      :resource="user"
      :title="$t('views.actions.discard')"
      :message="$t('views.users.discard.notice', { user: user.name })"
      action="discard"
    >
      <v-icon>{{ $vuetify.icons.values.delete }}</v-icon>
    </ResourceActionButton>

    <ResourceActionButton
      v-if="$can('undiscard', user)"
      :resource="user"
      :title="$t('views.actions.undiscard')"
      :message="$t('views.users.undiscard.notice', { user: user.username })"
      action="undiscard"
    >
      <v-icon>{{ $vuetify.icons.values.deleteRestore }}</v-icon>
    </ResourceActionButton>

    <ResourceActionButton
      v-if="$can('destroy', user)"
      :resource="user"
      :title="$t('views.actions.destroy')"
      :message="$t('views.users.destroy.notice', { user: user.name })"
      action="destroy"
    >
      <v-icon>{{ $vuetify.icons.values.deleteForever }}</v-icon>
    </ResourceActionButton>
  </div>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      required: true
    }
  }
};
</script>

<style lang="sass" scoped></style>
