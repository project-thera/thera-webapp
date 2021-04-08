import APILibrary from "@/resources/APILibrary";
import BaseResource from "@/resources/BaseResource";

import "./Routine";
import "./Exercise";

class RoutineExercise extends BaseResource {
  // required by active-resource
  // https://github.com/nicklandgrebe/active-resource.js/issues/47
  static className = "RoutineExercise";
  static queryName = "routine_exercises";

  // required by @casl/ability
  // https://stackoverflow.com/questions/57677510/casl-is-not-working-properly-in-vue-production-mode
  static modelName = "RoutineExercise";

  static define() {
    this.attributes("repetitions", "createdAt", "updatedAt");

    this.belongsTo("routine");
    this.belongsTo("exercise");
  }
}

export default APILibrary.createResource(RoutineExercise);
