<template>
  <div>
    <v-col cols="12">
      <TableActions
        :resources="users"
        route="admin-users"
        :filters="this.$store.state.filters.adminUsers"
      >
        <template #actions>
          <AddButton
            v-if="$can('create', 'User')"
            :to="{ name: 'admin-users-new' }"
            :text="$t('views.users.new.title')"
          />
        </template>
      </TableActions>
    </v-col>

    <v-col cols="12">
      <v-simple-table>
        <thead>
          <tr>
            <th>{{ $t("attributes.user.username") }}</th>
            <th>{{ $t("attributes.user.fullname") }}</th>
            <th>{{ $t("attributes.user.email") }}</th>
            <th>{{ $t("attributes.user.lastSignInAt") }}</th>
            <th>{{ $t("attributes.user.lastSignInIp") }}</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="user in users.toArray()"
            :key="user.id"
            @mouseover="selectedRow = user.id"
            @mouseleave="selectedRow = 0"
            @click="
              $can('show', user) &&
                $router.push({
                  name: 'users-show',
                  params: { id: user.id }
                })
            "
          >
            <td>
              <v-icon v-if="user.discarded">{{
                $vuetify.icons.values.delete
              }}</v-icon>
              {{ user.username }}
            </td>
            <td>
              {{ user.fullname }}
            </td>
            <td>
              {{ user.email }}
            </td>
            <td>{{ parseDate(user.lastSignInAt) }}</td>
            <td>{{ user.lastSignInIp }}</td>
            <td class="object-actions text-right d-none d-md-table-cell">
              <ObjectActions v-if="selectedRow === user.id" :user="user" />
              <div v-else>{{ $minifyUpdatedAt(user.updatedAt) }}</div>
            </td>
          </tr>
        </tbody>
      </v-simple-table>
    </v-col>
  </div>
</template>

<script>
import ObjectActions from "@/components/admin/users/ObjectActions";

export default {
  components: {
    ObjectActions
  },
  props: {
    users: {
      type: Object,
      default: null
    }
  },
  data({ users }) {
    return {
      selectedRow: 0,
      selectedRows: [],
      usersArray: users.toArray()
    };
  },
  mounted() {
    this.$bus.$on("toggle-select-all", allSelected =>
      allSelected ? this.selectAll() : (this.selectedRows = [])
    );
  },
  beforeDestroy() {
    this.$bus.$off("toggle-select-all");
  },
  methods: {
    selectAll() {
      this.selectedRows = this.groupsArray.map(group => group.id);
    },
    parseDate(date) {
      if (!date) return "";
      return this.$moment(date).format("DD/MM/YYYY hh:mm:ss");
    }
  }
};
</script>

<style lang="scss" scoped src="@/assets/stylesheets/table.scss"></style>
