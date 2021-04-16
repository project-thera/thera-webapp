<template>
  <div>
    <v-container v-if="loading">
      <v-row>
        <v-col v-for="i in 4" :key="i" cols="12" md="3">
          <v-skeleton-loader type="card" />
        </v-col>
      </v-row>
    </v-container>
    <v-container v-else>
      <v-row>
        <v-col
          v-for="routine in routines"
          :key="routine.id"
          cols="12"
          lg="3"
          sm="12"
        >
          <RoutineCard :routine="routine" />
        </v-col>
      </v-row>

      <v-row v-if="routines.length == 0">
        <p>El paciente no tiene rutinas</p>
      </v-row>

      <v-row>
        <v-btn
          v-if="$can('addRoutine', patient)"
          class="mt-2"
          color="primary"
          :title="$t('views.actions.addRoutine')"
          @click.stop="
            $router.push({
              name: 'admin-patients-add-routine',
              params: { id: patient.id }
            })
          "
        >
          Agregar Rutina
        </v-btn>
      </v-row>

      <div>
        <v-pagination v-model="page" :length="pageCount" @input="paginate" />
      </div>
    </v-container>
  </div>
</template>

<script>
import User from "@/resources/User";
import RoutineCard from "./RoutineCard";

export default {
  components: {
    RoutineCard
  },
  props: {
    patient: {
      type: User,
      required: true
    },
    loadRoutines: {
      type: Function,
      required: true
    },
    perPage: {
      type: Number,
      required: true
    },
    pageCount: {
      type: Number,
      required: true
    },
    routines: {
      type: Array,
      required: true
    },
    loading: {
      type: Boolean,
      required: true
    }
  },
  data() {
    return {
      console: console,
      page: 1
    };
  },
  mounted() {
    this.$bus.$on("update:resource", () => this.loadRoutines(this.page));
  },
  beforeDestroy() {
    this.$bus.$off("update:resource");
  },
  async created() {
    this.loadRoutines(this.page);
  },
  methods: {
    paginate(pageNumber) {
      this.page = pageNumber;

      this.loadRoutines(pageNumber);
    }
  }
};
</script>
