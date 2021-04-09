<template>
  <div>
    <v-btn
      v-if="$can('show', patient)"
      icon
      :title="$t('views.actions.show')"
      @click.stop="
        $router.push({
          name: 'admin-patients-show',
          params: { id: patient.id }
        })
      "
    >
      <v-icon medium>{{ $vuetify.icons.values.eye }}</v-icon>
    </v-btn>

    <ResourceActionButton
      v-if="$can('startSupervision', patient)"
      :resource="patient"
      :title="$t('views.actions.startSupervision')"
      :message="
        $t('views.patients.startSupervision.notice', {
          patient: patient.patientToString()
        })
      "
      action="start_supervision"
    >
      <v-icon medium>{{ $vuetify.icons.values.accountPlus }}</v-icon>
    </ResourceActionButton>

    <ResourceActionButton
      v-if="$can('stopSupervision', patient)"
      :resource="patient"
      :title="$t('views.actions.stopSupervision')"
      :message="
        $t('views.patients.stopSupervision.notice', {
          patient: patient.patientToString()
        })
      "
      action="stop_supervision"
    >
      <v-icon medium>{{ $vuetify.icons.values.accountMinus }}</v-icon>
    </ResourceActionButton>
  </div>
</template>

<script>
export default {
  props: {
    patient: {
      type: Object,
      required: true
    }
  }
};
</script>

<style lang="sass" scoped></style>
