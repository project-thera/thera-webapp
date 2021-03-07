<template>
  <div class="actions d-flex justify-space-between pb-2">
    <div>
      <div>
        <template v-if="$slots['batch-actions']">
          <input type="checkbox" @change="selectAll" />

          <ListMenu :icon="$vuetify.icons.values.chevronDown">
            <slot name="batch-actions" />
          </ListMenu>
        </template>

        <template v-if="$slots['list-actions']">
          <ListMenu>
            <slot name="list-actions" />
          </ListMenu>
        </template>

        <slot name="actions" />
      </div>
    </div>

    <div class="text-right">
      <template v-if="recordCount > 0">
        <!--
          <span class="text--secondary">
          Página {{ currentPage }} de {{ totalPages }}
          </span>
        -->
        <span class="text--secondary">
          Mostrando {{ startItem }}-{{ endItem }} de {{ recordCount }} registros
        </span>
        <v-btn icon class="mx-1" :disabled="!hasPrev" @click="prev">
          <v-icon>{{ $vuetify.icons.values.chevronLeft }}</v-icon>
        </v-btn>
        <v-btn icon class="mx-1" :disabled="!hasNext" @click="next">
          <v-icon>{{ $vuetify.icons.values.chevronRight }}</v-icon>
        </v-btn>

        <v-menu :close-on-content-click="false" offset-y>
          <template #activator="{ on }">
            <v-btn
              icon
              small
              title="Ir a la página"
              :disabled="totalPages == 1"
              v-on="on"
            >
              <v-icon>{{ $vuetify.icons.values.fileFind }}</v-icon>
            </v-btn>
          </template>
          <v-card>
            <ValidationObserver v-slot="{ invalid }">
              <v-card-text>
                <ValidationProvider
                  v-slot="{ errors }"
                  :rules="
                    `required|numeric|min_value:1|max_value:${totalPages}`
                  "
                >
                  <v-text-field
                    v-model="page"
                    type="number"
                    label="Página"
                    :error-messages="errors"
                  />
                </ValidationProvider>
              </v-card-text>
              <v-card-actions>
                <v-btn
                  text
                  :disabled="invalid"
                  color="primary"
                  @click="goToPage"
                >
                  IR
                </v-btn>
              </v-card-actions>
            </ValidationObserver>
          </v-card>
        </v-menu>
      </template>

      <template v-else>
        <span class="text-right text--secondary pr-4">
          No se han encontrado resultados
        </span>
      </template>
    </div>
  </div>
</template>

<script>
import { PAGE_SIZE } from "@/resources/BaseResource";

export default {
  props: {
    route: {
      type: String,
      required: true,
    },
    filters: {
      type: Object,
      required: true,
    },
    resources: {
      type: Object,
      required: true,
    },
    selectedRows: {
      type: Array,
      default: () => [],
    },
  },
  data({ resources, filters: { page } }) {
    return {
      allSelected: false,
      currentPage: page,
      page: page,
      recordCount: resources.meta().recordCount,
    };
  },
  computed: {
    hasNext() {
      return this.resources.hasNextPage && this.resources.hasNextPage();
    },
    hasPrev() {
      return this.resources.hasNextPage && this.resources.hasPrevPage();
    },
    totalPages() {
      return Math.ceil(this.resources.meta().recordCount / PAGE_SIZE);
    },
    startItem() {
      return (this.page - 1) * PAGE_SIZE + 1;
    },
    endItem() {
      return Math.min(this.startItem + PAGE_SIZE - 1, this.recordCount);
    },
  },
  watch: {
    filters: function(newFilters) {
      this.currentPage = newFilters.page;
      this.page = newFilters.page;
    },
    resources: function(newResources) {
      this.recordCount = newResources.meta().recordCount;
    },
  },
  methods: {
    selectAll() {
      this.allSelected = !this.allSelected;

      this.$bus.$emit("toggle-select-all", this.allSelected);
    },
    goToPage() {
      this.$router.push({
        name: this.route,
        query: { ...this.filters, page: this.page },
      });
    },
    next() {
      const { page, ...filters } = this.filters;

      this.$router.push({
        name: this.route,
        query: { ...filters, page: page + 1 },
      });
    },
    prev() {
      const { page, ...filters } = this.filters;

      this.$router.push({
        name: this.route,
        query: { ...filters, page: page - 1 },
      });
    },
  },
};
</script>

<style lang="sass" scoped>
.actions {
  border-bottom: thin solid rgba(0, 0, 0, .12);
}
</style>
