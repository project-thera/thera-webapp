<template>
  <v-card-actions>
    <v-btn
      v-if="$can('show', routine)"
      icon
      :title="$t('views.actions.show')"
      @click.stop="
        $router.push({
          name: 'admin-routines-show',
          params: { id: routine.id }
        })
      "
    >
      <v-icon big>{{ $vuetify.icons.values.eye }}</v-icon>
    </v-btn>

    <ResourceActionButton
      v-if="$can('discard', routine)"
      :resource="routine"
      :title="$t('views.actions.archive')"
      :message="
        $t('views.routines.discard.notice', {
          routine: routine.toString()
        })
      "
      action="discard"
    >
      <v-icon medium>{{ $vuetify.icons.values.archiveArrowDown }}</v-icon>
    </ResourceActionButton>

    <ResourceActionButton
      v-if="$can('undiscard', routine)"
      :resource="routine"
      :title="$t('views.actions.unarchive')"
      :message="
        $t('views.routines.undiscard.notice', {
          routine: routine.toString()
        })
      "
      action="undiscard"
    >
      <v-icon medium>{{ $vuetify.icons.values.archiveArrowUp }}</v-icon>
    </ResourceActionButton>

    <ResourceActionButton
      v-if="$can('destroy', routine)"
      :resource="routine"
      :title="$t('views.actions.destroy')"
      :message="
        $t('views.routines.destroy.notice', {
          routine: routine.toString()
        })
      "
      action="destroy"
    >
      <v-icon medium>{{ $vuetify.icons.values.deleteForever }}</v-icon>
    </ResourceActionButton>
  </v-card-actions>
</template>

<script>
import Routine from "@/resources/Routine";

export default {
  props: {
    routine: {
      type: Routine,
      required: true
    }
  }
};
</script>
