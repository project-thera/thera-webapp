import APILibrary from "@/resources/APILibrary";
import BaseResource from "@/resources/BaseResource";

import "./User";

class PatientVideo extends BaseResource {
  // required by active-resource
  // https://github.com/nicklandgrebe/active-resource.js/issues/47
  static className = "PatientVideo";
  static queryName = "PatientVideos";

  // required by @casl/ability
  // https://stackoverflow.com/questions/57677510/casl-is-not-working-properly-in-vue-production-mode
  static modelName = "PatientVideo";

  static define() {
    this.attributes("video", "createdAt", "updatedAt");

    this.belongsTo("patient", { className: "User" });
  }
}

export default APILibrary.createResource(PatientVideo);
