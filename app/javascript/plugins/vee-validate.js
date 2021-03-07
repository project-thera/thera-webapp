import Vue from "vue";
import { ValidationObserver, ValidationProvider } from "vee-validate";
import bytes from "bytes";

import {
  required,
  email,
  ext,
  min_value,
  max_value,
  size,
  mimes,
} from "vee-validate/dist/rules";

import { extend } from "vee-validate";

Vue.component("ValidationObserver", ValidationObserver);
Vue.component("ValidationProvider", ValidationProvider);

// document.addEventListener("DOMContentLoaded", () => {
//   const config = JSON.parse(document.getElementById("app").dataset.config);

//   extend("size", {
//     ...size,
//     validate: (files, _a) => {
//       if (_a.size > config.storage.max_size) {
//         throw "The size in client is bigger than the size declared in the de server, you must configure the max_size in the server";
//       }

//       return size.validate(files, _a);
//     },
//     message: (_, { size }) =>
//       `excede el valor máximo permitido (${bytes(size * 1024)})`, // vee-validate is in kilobytes
//   });
// });

extend("min_value", {
  ...min_value,
  message: "valor no permitido",
});

extend("max_value", {
  ...max_value,
  message: "valor no permitido",
});

extend("numeric", {
  ...ext,
  message: "debe ser un número",
});

extend("password", {
  params: ["target"],
  validate(value, { target }) {
    return value === target;
  },
  message: "las contraseñas deben coincidir",
});

// extend('ext', ext)

extend("required", {
  ...required,
  message: "no puede estar en blanco",
});

// extend('dossierNumber', value => {
//   const pattern = /EX-(?<year>\d{4})-(?<number>\d{0,8})-(( )?-)?GDEBA-(?<organization>\w+)/
//   return pattern.test(value) || 'No corresponde a un número de expediente.'
// });

extend("email", {
  ...email,
  message: "debe ser un email válido",
});

// extend("confirmed", {
//   ...confirmed,
//   message: "This field confirmation does not match"
// });

// extend("length", {
//   ...length,
//   message: "This field must have 2 options"
// });
