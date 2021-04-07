<template>
  <fragment>
    <v-tabs v-model="tab">
      <v-tab v-for="item in items" :key="item">
        {{ item }}
      </v-tab>
    </v-tabs>

    <v-tabs-items v-model="tab">
      <v-tab-item v-for="item in items" :key="item">
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
import OldRoutinesTab from "./OldRoutinesTab";
import FileTab from "./FileTab";

export default {
  components: {
    ActiveRoutinesTab,
    OldRoutinesTab,
    FileTab
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
      items: ["Rutinas Activas", "Rutinas Anteriores", "Ficha"],
      tabToComponent: {
        "Rutinas Activas": "ActiveRoutinesTab",
        "Rutinas Anteriores": "OldRoutinesTab",
        Ficha: "FileTab"
      }
    };
  }
};
</script>
