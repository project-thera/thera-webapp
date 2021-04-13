<template>
  <div>
    <article>
      <h1 class="mb-2">
        {{ $t("views.exercises.new.title") }}
      </h1>

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
