<template>
  <div>
    <v-container v-if="loading">
      <v-row>
        <v-col v-for="i in 4" :key="i" cols="12" md="2">
          <v-skeleton-loader type="card" />
        </v-col>
      </v-row>
    </v-container>
    <v-container v-else>
      <v-row>
        <v-col
          v-for="patientVideo in patientVideos"
          :key="patientVideo.id"
          cols="12"
          lg="2"
          sm="12"
        >
          <video v-if="$can('show', patientVideo)" height="320" controls>
            <source :src="patientVideo.links().video" />
          </video>
        </v-col>
      </v-row>

      <v-row v-if="patientVideos.length == 0">
        <p>El paciente no tiene videos</p>
      </v-row>

      <!--
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
      -->

      <div>
        <v-pagination v-model="page" :length="pageCount" @input="paginate" />
      </div>
    </v-container>
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
  data() {
    return {
      patientVideos: [],
      perPage: 6,
      pageCount: 1,
      page: 1,
      loading: true
    };
  },
  mounted() {
    this.$bus.$on("update:resource", () => this.loadPatientVideos(this.page));
  },
  beforeDestroy() {
    this.$bus.$off("update:resource");
  },
  async created() {
    this.loadPatientVideos(this.page);
  },
  methods: {
    async loadPatientVideos(pageNumber) {
      this.loading = true;

      const videoPatientsCollection = await this.patient
        .patientVideos()
        .page(pageNumber)
        .perPage(this.perPage)
        .all();

      console.log(videoPatientsCollection);
      this.patientVideos = videoPatientsCollection.toArray();
      this.pageCount = Math.ceil(
        videoPatientsCollection.meta().recordCount / this.perPage
      );

      this.loading = false;
    },
    paginate(pageNumber) {
      this.page = pageNumber;

      this.loadPatientVideos(pageNumber);
    }
  }
};
</script>
