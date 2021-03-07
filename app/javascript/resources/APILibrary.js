import { createResourceLibrary } from "../../../node_modules/active-resource/build/active-resource";
import axios from "axios";

const crsfToken = document.querySelector('[name="csrf-token"]');
axios.defaults.withCredentials = true;

export default createResourceLibrary(
  // base url for your server
  "/api/v1",
  {
    headers: { "X-CSRF-Token": crsfToken.content },
  }
);
