<template>
  <v-btn icon @click.stop="callAction">
    <slot />
  </v-btn>
</template>

<script>
export default {
  props: {
    resource: {
      type: Object,
      required: true
    },
    method: {
      type: String,
      default: "post"
    },
    action: {
      type: String,
      required: true
    },
    message: {
      type: String,
      default: "La operación se realizo con éxito"
    }
  },
  methods: {
    callAction: function() {
      const _this = this;
      // FIXME please
      const message = _this.message;

      if (this.action == "destroy") {
        this.resource
          .destroy()
          .then(() => {
            this.$bus.$emit("update:resource");

            _this.$toasted.success(_this.message);
          })
          .catch(() => {
            _this.$toasted.error(this.resource.getErrorsAsString());
          });
      } else {
        this.resource[this.method](this.action, function(resource) {
          if (resource.valid()) {
            _this.$bus.$emit("update:resource");

            _this.$toasted.success(message);
          } else {
            _this.$toasted.error(resource.getErrorsAsString());
          }
        });
      }
    }
  }
};
</script>
