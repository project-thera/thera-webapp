<template>
  <div>
    <v-col cols="12">
      <TableActions
        :resources="groups"
        route="admin-groups"
        :filters="this.$store.state.filters.adminGroups"
      >
        <template #actions>
          <AddButton
            v-if="$can('create', 'Group')"
            :to="{ name: 'admin-groups-new' }"
            :text="$t('views.groups.new.title')"
          />
        </template>
      </TableActions>
    </v-col>

    <v-col cols="12">
      <v-simple-table>
        <thead>
          <tr>
            <th>id</th>
            <th>{{ $t("attributes.group.name") }}</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="group in groups.toArray()"
            :key="group.id"
            @mouseover="selectedRow = group.id"
            @mouseleave="selectedRow = 0"
            @click="
              $can('show', group) &&
                $router.push({
                  name: 'groups-show',
                  params: { id: group.id },
                })
            "
          >
            <!-- <td>
              <input
                v-model="selectedRows"
                type="checkbox"
                :checked="selectedRows.includes(law.id)"
                :value="law.id"
              >
            </td> -->
            <td>#{{ group.id }}</td>
            <td>
              <v-icon v-if="group.discarded">{{
                $vuetify.icons.values.delete
              }}</v-icon>
              {{ group.name }}
            </td>
            <td class="object-actions text-right d-none d-md-table-cell">
              <ObjectActions v-if="selectedRow === group.id" :group="group" />
              <div v-else>{{
                $minifyUpdatedAt(group.updatedAt)
              }}</div>
            </td>
            <td class="d-table-cell d-md-none">
              <MoreActions>
                <v-list-item>Action #1</v-list-item>
                <v-list-item>Action #2</v-list-item>
                <v-list-item>Action #3</v-list-item>
                <v-list-item>Action #4</v-list-item>
              </MoreActions>
            </td>
          </tr>
        </tbody>
      </v-simple-table>
    </v-col>
  </div>
</template>

<script>
import ObjectActions from "@/components/admin/groups/ObjectActions";

export default {
  components: {
    ObjectActions,
  },
  props: {
    groups: {
      type: Object,
      default: null,
    },
  },
  data({ groups }) {
    return {
      selectedRow: 0,
      selectedRows: [],
      groupsArray: groups.toArray(),
    };
  },
  mounted() {
    this.$bus.$on("toggle-select-all", (allSelected) =>
      allSelected ? this.selectAll() : (this.selectedRows = [])
    );
  },
  beforeDestroy() {
    this.$bus.$off("toggle-select-all");
  },
  methods: {
    selectAll() {
      this.selectedRows = this.groupsArray.map((group) => group.id);
    },
  },
};
</script>

<style lang="scss" scoped src="@/assets/stylesheets/table.scss"></style>
