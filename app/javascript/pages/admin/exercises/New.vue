<template>
  <div>
    <article>
      <h2 class="mb-2 text-uppercase">
        {{ $t("views.exercises.new.title") }}
      </h2>

      <Form />
    </article>
  </div>
</template>

<script>
import Form from "@/components/admin/exercises/Form";

export default {
  components: {
    Form
  }
};
</script>
