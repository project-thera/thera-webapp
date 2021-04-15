<template>
  <div class="pt-8">
    <v-tabs v-model="tab">
      <v-tab
        v-for="item in Object.keys(tabToComponent)"
        :key="item"
        :href="`#${item}`"
      >
        {{ item }}
      </v-tab>
    </v-tabs>
    <v-tabs-items v-model="tab">
      <v-tab-item
        v-for="item in Object.keys(tabToComponent)"
        :key="item"
        :value="item"
      >
        <v-card flat class="pa-2">
          <component :is="tabToComponent[item]" :patient="patient" />
        </v-card>
      </v-tab-item>
    </v-tabs-items>
  </div>
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
      tabToComponent: {
        "Rutinas Activas": "ActiveRoutinesTab",
        Ficha: "FileTab",
        Seguimiento: "TrackingTab",
        "Rutinas Archivadas": "ArchivedRoutinesTab"
      }
    };
  },
  computed: {
    tab: {
      set(tab) {
        this.$router.replace({ query: { ...this.$route.query, tab } });
      },
      get() {
        return this.$route.query.tab;
      }
    }
  }
};
</script>
