<template>
  <v-row class="fill-height">
    <v-col>
      <v-sheet height="64">
        <v-toolbar flat>
          <v-btn outlined class="mr-4" color="grey darken-2" @click="setToday">
            Hoy
          </v-btn>
          <v-btn fab text small color="grey darken-2" @click="prev">
            <v-icon>
              {{ $vuetify.icons.values.chevronLeft }}
            </v-icon>
          </v-btn>
          <v-btn fab text small color="grey darken-2" @click="next">
            <v-icon>
              {{ $vuetify.icons.values.chevronRight }}
            </v-icon>
          </v-btn>
          <v-toolbar-title v-if="$refs.calendar">
            {{ $refs.calendar.title }}
          </v-toolbar-title>
          <v-spacer></v-spacer>
          <v-menu bottom right>
            <template #activator="{ on, attrs }">
              <v-btn outlined color="grey darken-2" v-bind="attrs" v-on="on">
                <span>{{ typeToLabel[type] }}</span>
                <v-icon right>
                  mdi-menu-down
                </v-icon>
              </v-btn>
            </template>
            <v-list>
              <v-list-item @click="type = 'month'">
                <v-list-item-title>Mes</v-list-item-title>
              </v-list-item>
              <v-list-item @click="type = 'week'">
                <v-list-item-title>Semana</v-list-item-title>
              </v-list-item>
              <v-list-item @click="type = 'day'">
                <v-list-item-title>Día</v-list-item-title>
              </v-list-item>
            </v-list>
          </v-menu>
        </v-toolbar>
      </v-sheet>
      <v-sheet height="800">
        <v-calendar
          ref="calendar"
          v-model="focus"
          color="primary"
          :events="events"
          :event-color="getEventColor"
          :type="type"
          event-overlap-mode="column"
          :hide-header="false"
          :interval-minutes="0"
          :interval-height="0"
          :interval-count="0"
          :event-overlap-threshold="0"
          @click:event="showEvent"
          @click:more="viewDay"
          @click:date="viewDay"
          @change="updateRange"
        ></v-calendar>
        <v-menu
          v-model="selectedOpen"
          :close-on-content-click="false"
          :activator="selectedElement"
          offset-x
        >
          <v-card color="grey lighten-4" min-width="350px" flat>
            <template v-if="selectedEvent">
              <v-toolbar :color="selectedEvent.color" dark>
                <v-btn icon>
                  <v-icon>mdi-pencil</v-icon>
                </v-btn>
                <v-toolbar-title v-html="selectedEvent.name" />
                <v-spacer></v-spacer>
                <v-btn icon>
                  <v-icon>mdi-heart</v-icon>
                </v-btn>
                <v-btn icon>
                  <v-icon>mdi-dots-vertical</v-icon>
                </v-btn>
              </v-toolbar>
              <v-card-text>
                <v-list>
                  <v-list-item
                    v-for="routineIntentExercise in selectedEvent.routineIntent
                      .routineIntentExercises()
                      .toArray()"
                    :key="routineIntentExercise.id"
                    :style="{ minHeight: '28px' }"
                  >
                    <v-list-item-content class="pa-0">
                      <v-list-item-title
                        >{{ routineIntentExercise.exercise().name }} ({{
                          routineIntentExercise.status
                        }})</v-list-item-title
                      >
                    </v-list-item-content>
                  </v-list-item>
                </v-list>
              </v-card-text>
              <v-card-actions>
                <v-btn text color="secondary" @click="selectedOpen = false">
                  Cancel
                </v-btn>
              </v-card-actions>
            </template>
          </v-card>
        </v-menu>
      </v-sheet>
    </v-col>
  </v-row>
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
  data: () => ({
    focus: "",
    type: "month",
    typeToLabel: {
      month: "Mes",
      week: "Semana",
      day: "Día"
    },
    selectedEvent: null,
    selectedElement: null,
    selectedOpen: false,
    events: [],
    colors: [
      "blue",
      "indigo",
      "deep-purple",
      "cyan",
      "green",
      "orange",
      "grey darken-1"
    ]
  }),
  mounted() {
    this.$refs.calendar.checkChange();
  },
  methods: {
    viewDay({ date }) {
      this.focus = date;
      this.type = "day";
    },
    getEventColor(event) {
      return event.color;
    },
    setToday() {
      this.focus = "";
    },
    prev() {
      this.$refs.calendar.prev();
    },
    next() {
      this.$refs.calendar.next();
    },
    showEvent({ nativeEvent, event }) {
      const open = () => {
        this.selectedEvent = event;
        this.selectedElement = nativeEvent.target;
        setTimeout(() => {
          this.selectedOpen = true;
        }, 10);
      };

      if (this.selectedOpen) {
        this.selectedOpen = false;
        setTimeout(open, 10);
      } else {
        open();
      }

      nativeEvent.stopPropagation();
    },
    async updateRange({ start, end }) {
      const events = [];

      const min = new Date(`${start.date}T00:00:00`);
      const max = new Date(`${end.date}T23:59:59`);

      const routineIntents = (
        await this.patient
          .routineIntents()
          .includes("routine", { routineIntentExercises: ["exercise"] })
          .where({ startedAtLteq: max, startedAtGteq: min })
          .all()
      ).toArray();

      for (const routineIntent of routineIntents) {
        events.push({
          name: routineIntent.routine().toString(),
          start: new Date(routineIntent.startedAt),
          color: this.colors[this.random(0, this.colors.length - 1)],
          timed: false,
          routineIntent: routineIntent
        });
      }

      this.events = events;
    },
    random(a, b) {
      return Math.floor((b - a + 1) * Math.random()) + a;
    }
  }
};
</script>
