<template>
  <div>
    <v-col cols="12">
      <TableActions
        :resources="patients"
        route="admin-patients"
        :filters="$store.state.filters.adminPatients"
      >
        <template #actions>
          <AddButton
            v-if="$can('create', 'patient')"
            :to="{ name: 'admin-patients-new' }"
            :text="$t('views.patients.new.title')"
          />
        </template>
      </TableActions>
    </v-col>

    <v-col cols="12">
      <v-simple-table>
        <thead>
          <tr>
            <th>{{ $t("attributes.user.fullname") }}</th>
            <th>{{ $t("attributes.user.lastSignInAt") }}</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="patient in patients.toArray()"
            :key="patient.id"
            @mouseover="selectedRow = patient.id"
            @mouseleave="selectedRow = 0"
            @click="
              $can('show', patient) &&
                $router.push({
                  name: 'admin-patients-show',
                  params: { id: patient.id }
                })
            "
          >
            <td>
              <v-icon v-if="patient.discarded">{{
                $vuetify.icons.values.delete
              }}</v-icon>
              {{ patient.fullname }}
            </td>
            <td>{{ parseDate(patient.lastSignInAt) }}</td>
            <td class="object-actions text-right d-none d-md-table-cell">
              <ObjectActions
                v-if="selectedRow === patient.id"
                :patient="patient"
              />
              <div v-else>{{ $minifyUpdatedAt(patient.updatedAt) }}</div>
            </td>
          </tr>
        </tbody>
      </v-simple-table>
    </v-col>
  </div>
</template>

<script>
import ObjectActions from "@/components/admin/patients/ObjectActions";

export default {
  components: {
    ObjectActions
  },
  props: {
    patients: {
      type: Object,
      default: null
    }
  },
  data({ patients }) {
    return {
      selectedRow: 0,
      selectedRows: [],
      patientsArray: patients.toArray()
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
