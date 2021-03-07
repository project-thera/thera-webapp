<template>
  <div id="user-menu" align="center">
    <v-menu attach="#user-menu" tile left offset-y>
      <template #activator="{ on }">
        <v-btn icon x-large tile class="white--text" :ripple="false" v-on="on">
          <v-icon>{{ $vuetify.icons.values.accountCircle }}</v-icon>
        </v-btn>
      </template>

      <v-list>
        <!-- <v-list-item :key="'Cambiar contraseña'">
          <v-list-item-action tile class="mr-2">
            <v-icon color="grey darken-1">
              vpn_key
            </v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title> Cambiar contraseña </v-list-item-title>
          </v-list-item-content>
        </v-list-item> -->

        <v-list-item
          :key="'Cerrar sesión'"
          data-no-turbolink="true"
          :href="signOutUrl"
        >
          <v-list-item-action tile class="mr-2">
            <v-icon color="grey darken-1">
              {{ $vuetify.icons.values.exitToApp }}
            </v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title> Cerrar sesión </v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-menu>
  </div>
</template>

<script>
export default {
  name: "UserMenu",
  data() {
    return {
      signOutUrl: window.location.origin + "/users/sign_out",
    };
  },
};
</script>

<!-- El componente del menu no toma el tile por lo que puse el border radius a 0 y no encontre otra forma de acomodar el menu en el top, hay que ver mejores soluciones -->

<style scoped></style>
