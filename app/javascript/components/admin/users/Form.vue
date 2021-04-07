<template>
  <div>
    <ValidationObserver ref="form" v-slot="{ handleSubmit }">
      <v-form @submit.prevent="handleSubmit(onSubmit)">
        <v-container fluid>
          <v-row no-gutters>
            <v-col cols="12">
              <ValidationProvider v-slot="{ errors }" vid="username">
                <v-text-field
                  v-model="object.username"
                  :label="$t('attributes.user.username')"
                  required
                  :error-messages="errors"
                />
              </ValidationProvider>
            </v-col>
            <v-col cols="12">
              <ValidationProvider v-slot="{ errors }" vid="fullname">
                <v-text-field
                  v-model="object.fullname"
                  :label="$t('attributes.user.fullname')"
                  :error-messages="errors"
                />
              </ValidationProvider>
            </v-col>
            <v-col cols="12">
              <ValidationProvider v-slot="{ errors }" vid="email">
                <v-text-field
                  v-model="object.email"
                  :label="$t('attributes.user.email')"
                  :error-messages="errors"
                />
              </ValidationProvider>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="12">
              <ValidationProvider v-slot="{ errors }" vid="groupIds">
                <v-select
                  v-model="object.groupIds"
                  :items="groups"
                  :label="$t('attributes.user.groups')"
                  item-value="id"
                  item-text="name"
                  required
                  outlined
                  chips
                  multiple
                  :error-messages="errors"
                />
              </ValidationProvider>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="12">
              <SaveButton />
              <DiscardButton to="/admin/usuarios" />
            </v-col>
          </v-row>
        </v-container>
      </v-form>
    </ValidationObserver>
  </div>
</template>

<script>
import Group from "@/resources/Group";
import User from "@/resources/User";

export default {
  props: {
    user: {
      type: User,
      default: () => User.build()
    }
  },
  data: ({ user }) => {
    return {
      object: user.attributes(),
      groups: []
    };
  },
  created() {
    this.loadGroups();
  },
  methods: {
    async loadGroups() {
      const groups = await Group.all();
      this.groups = groups.toArray();
    },
    async onSubmit() {
      if (this.$refs.form.validate()) {
        this.user.assignAttributes(this.object);
        try {
          await this.user.save();
          this.$router.push({ name: "admin-users" });
          this.$toasted.success(
            this.$t("views.users.create.notice", { user: this.user.username })
          );
        } catch {
          this.$refs.form.setErrors(this.user.getErrors());
        }
      }
    }
  }
};
</script>
