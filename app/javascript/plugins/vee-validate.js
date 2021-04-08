import Vue from "vue";
import { ValidationObserver, ValidationProvider } from "vee-validate";

import {
  required,
  email,
  ext,
  min_value,
  max_value,
  integer
} from "vee-validate/dist/rules";

import { extend } from "vee-validate";

Vue.component("ValidationObserver", ValidationObserver);
Vue.component("ValidationProvider", ValidationProvider);

extend("min_value", {
  ...min_value,
  message: "valor no permitido"
});

extend("max_value", {
  ...max_value,
  message: "valor no permitido"
});

extend("integer", {
  ...integer,
  message: "debe ser un número entero"
});

extend("numeric", {
  ...ext,
  message: "debe ser un número"
});

extend("password", {
  params: ["target"],
  validate(value, { target }) {
    return value === target;
  },
  message: "las contraseñas deben coincidir"
});

// extend('ext', ext)

extend("required", {
  ...required,
  message: "no puede estar en blanco"
});

// extend('dossierNumber', value => {
//   const pattern = /EX-(?<year>\d{4})-(?<number>\d{0,8})-(( )?-)?GDEBA-(?<organization>\w+)/
//   return pattern.test(value) || 'No corresponde a un número de expediente.'
// });

extend("email", {
  ...email,
  message: "debe ser un email válido"
});

// extend("confirmed", {
//   ...confirmed,
//   message: "This field confirmation does not match"
// });

// extend("length", {
//   ...length,
//   message: "This field must have 2 options"
// });
