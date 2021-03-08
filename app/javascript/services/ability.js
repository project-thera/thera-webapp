import { defineAbility } from "@casl/ability";

export default function defineAbilityFor(user) {
  return defineAbility((can) => {
    user.hasGroup = function(groupName) {
      return this.groups.includes(groupName);
    };

    if (user.hasGroup("System Administrator")) {
      can("index", "User");
      can("update", "User");
      can("create", "User");
      can("discard", "User", { discarded: false });
      can("undiscard", "User", { discarded: true });
      can("destroy", "User");

      can("index", "Group");

      can("index", "Exercise");
      can("update", "Exercise");
      can("create", "Exercise");
      can("discard", "Exercise", { discarded: false });
      can("undiscard", "Exercise", { discarded: true });
      can("destroy", "Exercise");
    }

    if (user.hasGroup("Administrator")) {
    }

    if (user.hasGroup("Operador")) {
    }
  });
}
