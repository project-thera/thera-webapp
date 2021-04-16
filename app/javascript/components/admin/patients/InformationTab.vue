<template>
  <div class="mt-4">
    <v-row>
      <v-col cols="12" md="6">
        <div class="d-flex">
          <v-textarea
            v-model="file"
            :disabled="!editing"
            :label="$t('attributes.user.file')"
          />
          <v-btn
            v-if="$can('updateFile', patient)"
            icon
            class="ma-4"
            :title="$t('views.actions.edit')"
            @click="makeEditable"
          >
            <v-icon>
              {{ $vuetify.icons.values.pencil }}
            </v-icon>
          </v-btn>
        </div>
        <template v-if="editing">
          <v-btn
            tile
            class="mr-4"
            color="success"
            :loading="loading"
            @click="save"
          >
            {{ $t("views.actions.save") }}
          </v-btn>
          <v-btn tile text title="Cancelar" @click="cancel">
            {{ $t("views.actions.cancel") }}
          </v-btn>
        </template>
      </v-col>
    </v-row>
  </div>
</template>

<script>
import User from "@/resources/User";

export default {
  props: {
    patient: {
      type: User,
      required: true
    }
  },
  data: ({ patient }) => {
    return {
      file: patient.file,
      editing: false,
      loading: false
    };
  },
  methods: {
    makeEditable() {
      this.editing = true;
    },
    async save() {
      this.loading = true;

      try {
        await this.patient.update({ file: this.file });

        this.loading = false;

        this.$toasted.success(
          this.$t("views.patients.updateFile.notice", {
            patient: this.patient.toString()
          })
        );

        this.editing = false;
      } catch {
        this.$t("views.patients.updateFile.alert", {
          patient: this.patient.toString()
        });

        this.loading = false;
      }
    },
    cancel() {
      this.file = this.patient.file;
      this.editing = false;
    }
  }
};
</script>

<style>
.theme--light.v-input--is-disabled textarea {
  color: rgba(0, 0, 0, 0.87);
}
</style>
