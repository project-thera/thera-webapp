<template>
  <div id="search-input" align="center" class="mt-7">
    <v-text-field
      v-model="search"
      :prepend-inner-icon="$vuetify.icons.values.magnify"
      :placeholder="placeholder"
      background-color="white"
      solo
      @click:prepend-inner="onSearch"
      @click:clear="onClear"
      @keyup.native.enter="onSearch"
    >
      <template #append>
        <v-btn v-if="showClear" icon small @click="onClear">
          <v-icon x-medium>
            {{ $vuetify.icons.values.close }}
          </v-icon>
        </v-btn>
        <template v-if="$slots.default">
          <FilterMenu v-if="smAndUp" :show-badge="showBadge">
            <slot />
          </FilterMenu>
          <FilterModal v-if="!smAndUp" :show-badge="showBadge">
            <slot />
          </FilterModal>
        </template>
      </template>
    </v-text-field>
  </div>
</template>

<script>
export default {
  props: {
    route: {
      type: String,
      required: true
    },
    searchParam: {
      type: String,
      default: "search"
    },
    placeholder: {
      type: String,
      default: "Buscar"
    },
    filters: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      search: null
    };
  },
  computed: {
    showBadge() {
      return (
        Object.entries(this.filters).filter(
          ([key, value]) =>
            key != "page" &&
            key != this.searchParam &&
            value != null &&
            value != ""
        ).length > 0
      );
    },
    showClear() {
      return (
        this.filters[this.searchParam] && this.filters[this.searchParam] != null
      );
    },
    smAndUp() {
      return this.$vuetify.breakpoint.smAndUp;
    }
  },
  watch: {
    route: function() {
      this.search = this.filters[this.searchParam];
    }
  },
  methods: {
    onSearch() {
      this.$router.push({
        name: this.route,
        query: { [this.searchParam]: this.search }
      });
    },
    onClear() {
      this.$router.push({
        name: this.route,
        query: { _clear: true }
      });
    }
  }
};
</script>

<style lang="scss" scoped>
#search-input {
  width: 650px;
  position: relative;

  @media (max-width: 800px) {
    width: 400px;
  }

  @media (max-width: 500px) {
    width: 300px;
  }

  @media (max-width: 400px) {
    width: 200px;
  }
}

.col {
  padding-top: 2px !important;
}
</style>
