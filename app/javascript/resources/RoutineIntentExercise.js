import APILibrary from "@/resources/APILibrary";
import BaseResource from "@/resources/BaseResource";

import "./RoutineIntent";
import "./Exercise";

class RoutineIntentExercise extends BaseResource {
  // required by active-resource
  // https://github.com/nicklandgrebe/active-resource.js/issues/47
  static className = "RoutineIntentExercise";
  static queryName = "routine_intent_exercises";

  // required by @casl/ability
  // https://stackoverflow.com/questions/57677510/casl-is-not-working-properly-in-vue-production-mode
  static modelName = "RoutineIntentExercise";

  static define() {
    this.attributes("status");

    this.belongsTo("routineIntent");
    this.belongsTo("exercise");
  }
}

export default APILibrary.createResource(RoutineIntentExercise);
