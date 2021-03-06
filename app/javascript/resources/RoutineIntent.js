import APILibrary from "@/resources/APILibrary";
import BaseResource from "@/resources/BaseResource";

import "./Routine";
import "./RoutineIntentExercise";

class RoutineIntent extends BaseResource {
  // required by active-resource
  // https://github.com/nicklandgrebe/active-resource.js/issues/47
  static className = "RoutineIntent";
  static queryName = "routine_intents";

  // required by @casl/ability
  // https://stackoverflow.com/questions/57677510/casl-is-not-working-properly-in-vue-production-mode
  static modelName = "RoutineIntent";

  static define() {
    this.attributes("startedAt", "finishedAt", "createdAt", "updatedAt");

    this.belongsTo("routine");

    this.hasMany("routineIntentExercises");
  }

  status() {
    return this.finishedAt ? "finished" : "unfinished";
  }

  finished() {
    return this.finishedAt;
  }

  static statuses() {
    return ["finished", "unfinished"];
  }
}

export default APILibrary.createResource(RoutineIntent);
