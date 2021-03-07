<template>
  <v-menu offset-y>
    <template #activator="{ on }">
      <v-btn icon title="Más acciones" v-on="on">
        <v-icon>{{ $vuetify.icons.values.dotsVertical }}</v-icon>
      </v-btn>
    </template>
    <v-list dense>
      <v-list-item-group>
        <slot />
      </v-list-item-group>
    </v-list>
  </v-menu>
</template>
