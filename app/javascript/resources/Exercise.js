import APILibrary from "@/resources/APILibrary";
import BaseResource from "@/resources/BaseResource";

import { exerciseTypes } from "@/data/exercise-types";

class Exercise extends BaseResource {
  // required by active-resource
  // https://github.com/nicklandgrebe/active-resource.js/issues/47
  static className = "Exercise";
  static queryName = "exercises";

  // required by @casl/ability
  // https://stackoverflow.com/questions/57677510/casl-is-not-working-properly-in-vue-production-mode
  static modelName = "Exercise";

  static define() {
    this.attributes(
      "name",
      "exercise_type",
      "description",
      "steps",
      "createdAt",
      "updatedAt"
    );
  }

  toString() {
    return `${this.name}`;
  }
}

export default APILibrary.createResource(Exercise);
