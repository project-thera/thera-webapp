<template>
  <fragment>
    <template v-if="routines">
      <v-container>
        <v-row>
          <v-col
            v-for="routine in routines"
            :key="routine.id"
            cols="12"
            sm="12"
            md="3"
          >
            <v-hover v-slot="{ hover }">
              <v-card
                :elevation="hover ? 8 : 2"
                :class="{ 'on-hover': hover }"
                class="ma-4 pa-4"
              >
                <v-card-title>{{ routine.toString() }}</v-card-title>
                <v-card-subtitle
                  >Creada
                  {{ $minifyUpdatedAt(routine.createdAt) }}</v-card-subtitle
                >
                <v-list>
                  <v-list-item
                    v-for="routineExercise in routine
                      .routineExercises()
                      .toArray()"
                    :key="routineExercise.id"
                    :style="{ minHeight: '28px' }"
                  >
                    <v-list-item-content class="pa-0">
                      <v-list-item-title
                        >{{ routineExercise.exercise().name }} ({{
                          routineExercise.repetitions
                        }})</v-list-item-title
                      >
                    </v-list-item-content>
                  </v-list-item>
                </v-list>
                <v-card-actions>
                  <v-btn
                    v-if="$can('show', routine)"
                    icon
                    :title="$t('views.actions.show')"
                    @click.stop="
                      $router.push({
                        name: 'admin-routines-show',
                        params: { id: routine.id }
                      })
                    "
                  >
                    <v-icon big>{{ $vuetify.icons.values.eye }}</v-icon>
                  </v-btn>

                  <ResourceActionButton
                    v-if="$can('discard', routine)"
                    :resource="routine"
                    :title="$t('views.actions.archive')"
                    :message="
                      $t('views.routines.discard.notice', {
                        routine: routine.toString()
                      })
                    "
                    action="discard"
                  >
                    <v-icon medium>{{
                      $vuetify.icons.values.archiveArrowDown
                    }}</v-icon>
                  </ResourceActionButton>

                  <ResourceActionButton
                    v-if="$can('undiscard', routine)"
                    :resource="routine"
                    :title="$t('views.actions.unarchive')"
                    :message="
                      $t('views.routines.undiscard.notice', {
                        routine: routine.toString()
                      })
                    "
                    action="undiscard"
                  >
                    <v-icon medium>{{
                      $vuetify.icons.values.archiveArrowUp
                    }}</v-icon>
                  </ResourceActionButton>

                  <ResourceActionButton
                    v-if="$can('destroy', routine)"
                    :resource="routine"
                    :title="$t('views.actions.destroy')"
                    :message="
                      $t('views.routines.destroy.notice', {
                        routine: routine.toString()
                      })
                    "
                    action="destroy"
                  >
                    <v-icon medium>{{
                      $vuetify.icons.values.deleteForever
                    }}</v-icon>
                  </ResourceActionButton>
                </v-card-actions>
              </v-card>
            </v-hover>
          </v-col>
        </v-row>
        <v-btn
          v-if="$can('addRoutine', patient)"
          color="primary"
          :title="$t('views.actions.edit')"
          @click.stop="
            $router.push({
              name: 'admin-patients-add-routine',
              params: { id: patient.id }
            })
          "
        >
          Agregar Rutina
        </v-btn>

        <div>
          <v-pagination v-model="page" :length="pageCount" @input="paginate" />
        </div>
      </v-container>
    </template>
  </fragment>
</template>

<script>
import User from "@/resources/User";

export default {
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
