import APILibrary from "@/resources/APILibrary";
import BaseResource from "@/resources/BaseResource";

import "./Group";
import "./Routine";
import "./RoutineIntent";
import "./GameReward";

class GameReward extends BaseResource {
  // required by active-resource
  // https://github.com/nicklandgrebe/active-resource.js/issues/47
  static className = "GameReward";
  static queryName = "game_rewards";

  // required by @casl/ability
  // https://stackoverflow.com/questions/57677510/casl-is-not-working-properly-in-vue-production-mode
  static modelName = "GameReward";

  static define() {
    this.attributes("credits", "robots", "currentRobot");
  }
}

export default APILibrary.createResource(GameReward);
