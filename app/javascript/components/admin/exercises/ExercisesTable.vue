<template>
  <div>
    <v-col cols="12">
      <TableActions
        :resources="exercises"
        route="admin-exercises"
        :filters="$store.state.filters.adminExercises"
      >
        <template #actions>
          <AddButton
            v-if="$can('create', 'Exercise')"
            :to="{ name: 'admin-exercises-new' }"
            :text="$t('views.exercises.new.title')"
          />
        </template>
      </TableActions>
    </v-col>

    <v-col cols="12">
      <v-simple-table>
        <thead>
          <tr>
            <th>{{ $t("attributes.exercise.name") }}</th>
            <th>{{ $t("attributes.exercise.exerciseType") }}</th>
            <th>{{ $t("attributes.exercise.description") }}</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="exercise in exercises.toArray()"
            :key="exercise.id"
            @mouseover="selectedRow = exercise.id"
            @mouseleave="selectedRow = 0"
            @click="
              $can('show', exercise) &&
                $router.push({
                  name: 'exercises-show',
                  params: { id: exercise.id }
                })
            "
          >
            <td>
              <v-icon v-if="exercise.discarded">{{
                $vuetify.icons.values.delete
              }}</v-icon>
              {{ exercise.name }}
            </td>
            <td>
              {{ $serverParameters.exercise_types[exercise.exerciseType] }}
            </td>
            <td>
              {{ exercise.description }}
            </td>
            <td class="object-actions text-right d-none d-md-table-cell">
              <ObjectActions
                v-if="selectedRow === exercise.id"
                :exercise="exercise"
              />
              <div v-else>{{ $minifyUpdatedAt(exercise.updatedAt) }}</div>
            </td>
          </tr>
        </tbody>
      </v-simple-table>
    </v-col>
  </div>
</template>

<script>
import ObjectActions from "@/components/admin/exercises/ObjectActions";

export default {
  components: {
    ObjectActions
  },
  props: {
    exercises: {
      type: Object,
      default: null
    }
  },
  data({ exercises }) {
    return {
      selectedRow: 0,
      selectedRows: [],
      exercisesArray: exercises.toArray()
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
      this.selectedRows = this.exercisesArray.map(exercise => exercise.id);
    },
    parseDate(date) {
      if (!date) return "";
      return this.$moment(date).format("DD/MM/YYYY hh:mm:ss");
    }
  }
};
</script>

<style lang="scss" scoped src="@/assets/stylesheets/table.scss"></style>
