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
import InformationTab from "./InformationTab";
import VideosTab from "./VideosTab";
import TrackingTab from "./TrackingTab";

export default {
  components: {
    ActiveRoutinesTab,
    ArchivedRoutinesTab,
    InformationTab,
    VideosTab,
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
        Información: "InformationTab",
        "Rutinas Activas": "ActiveRoutinesTab",
        Seguimiento: "TrackingTab",
        Videos: "VideosTab",
        "Rutinas Archivadas": "ArchivedRoutinesTab"
      }
    };
  },
  computed: {
    tab: {
      set(tab) {
        console.log(tab);
        this.$router.replace({ query: { ...this.$route.query, tab } });
      },
      get() {
        console.log(this.$route.query.tab);
        return this.$route.query.tab;
      }
    }
  }
};
</script>
