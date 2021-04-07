import APILibrary from "@/resources/APILibrary";
import BaseResource from "@/resources/BaseResource";

class Routine extends BaseResource {
  // required by active-resource
  // https://github.com/nicklandgrebe/active-resource.js/issues/47
  static className = "Routine";
  static queryName = "routines";

  // required by @casl/ability
  // https://stackoverflow.com/questions/57677510/casl-is-not-working-properly-in-vue-production-mode
  static modelName = "Routine";

  static define() {
    this.attributes("name", "discarded");

    this.belongsTo("patient", { className: "User" });
  }
}

export default APILibrary.createResource(Routine);
