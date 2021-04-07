import APILibrary from "@/resources/APILibrary";
import BaseResource, { PAGE_SIZE } from "@/resources/BaseResource";

class User extends BaseResource {
  // required by active-resource
  // https://github.com/nicklandgrebe/active-resource.js/issues/47
  static className = "User";
  static queryName = "users";

  // required by @casl/ability
  // https://stackoverflow.com/questions/57677510/casl-is-not-working-properly-in-vue-production-mode
  static modelName = "User";

  static define() {
    this.attributes(
      "username",
      "discarded",
      "lastSignInAt",
      "lastSignInIp",
      "groupIds"
    );

    this.hasMany("groups");
  }

  toString() {
    return `${this.username}`;
  }

  static async listPatients(params) {
    const { page, ...filters } = params;

    const res = await this.where(filters)
      .where({ patients: true })
      .order({ updatedAt: "desc" })
      .perPage(PAGE_SIZE)
      .page(page)
      .all();

    return res;
  }
}

export default APILibrary.createResource(User);
