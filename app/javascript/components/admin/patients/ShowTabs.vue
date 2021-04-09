<template>
  <fragment>
    <v-tabs v-model="tab">
      <v-tab v-for="item in Object.keys(tabToComponent)" :key="item">
        {{ item }}
      </v-tab>
    </v-tabs>

    <v-tabs-items v-model="tab">
      <v-tab-item v-for="item in Object.keys(tabToComponent)" :key="item">
        <v-card flat>
          <component :is="tabToComponent[item]" :patient="patient" />
        </v-card>
      </v-tab-item>
    </v-tabs-items>
  </fragment>
</template>

<script>
import User from "@/resources/User";
import ActiveRoutinesTab from "./ActiveRoutinesTab";
import ArchivedRoutinesTab from "./ArchivedRoutinesTab";
import FileTab from "./FileTab";
import TrackingTab from "./TrackingTab";

export default {
  components: {
    ActiveRoutinesTab,
    ArchivedRoutinesTab,
    FileTab,
    TrackingTab
  },
  props: {
    patient: {
      type: User,
      required: true
    }
  },
  data() {
    return {
      tab: null,
      tabToComponent: {
        "Rutinas Activas": "ActiveRoutinesTab",
        Ficha: "FileTab",
        Seguimiento: "TrackingTab",
        "Rutinas Archivadas": "ArchivedRoutinesTab"
      }
    };
  }
};
</script>
