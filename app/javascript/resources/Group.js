import APILibrary from "@/resources/APILibrary";
import BaseResource from "@/resources/BaseResource";

class Group extends BaseResource {
  // required by active-resource
  // https://github.com/nicklandgrebe/active-resource.js/issues/47
  static className = "Group";
  static queryName = "groups";

  // required by @casl/ability
  // https://stackoverflow.com/questions/57677510/casl-is-not-working-properly-in-vue-production-mode
  static modelName = "Group";

  static define() {
    this.attributes("name", "discarded");

    this.hasMany("users");
  }

  /*
    Por defecto las propiedades se transforman a camelCase
  */
  toLabel() {
    return `${this.name}`;
  }
}

export default APILibrary.createResource(Group);
