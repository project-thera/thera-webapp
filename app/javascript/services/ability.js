import { defineAbility } from "@casl/ability";

export default function defineAbilityFor(user) {
  return defineAbility((can, cannot) => {
    const discardCondition = { discarded: false };
    const undiscardCondition = { discarded: true };
    const startSupervisionCondition = { supervisorId: null };

    user.hasGroup = function(groupName) {
      return this.groups.includes(groupName);
    };

    if (user.hasGroup("System Administrator")) {
      can("index", "Group");

      can("index", "User");
      can("update", "User");
      can("create", "User");
      can("discard", "User", discardCondition);
      can("undiscard", "User", undiscardCondition);
      can("destroy", "User");
      can("show", "User");
      can("addRoutine", "User");
      can("startSupervision", "User", startSupervisionCondition);
      can("stopSupervision", "User");
      cannot("stopSupervision", "User", startSupervisionCondition);

      can("index", "Patient");

      can("show", "Routine");
      can("discard", "Routine", discardCondition);
      can("undiscard", "Routine", undiscardCondition);
      can("destroy", "Routine");

      can("index", "Exercise");
      can("update", "Exercise");
      can("create", "Exercise");
      can("discard", "Exercise", discardCondition);
      can("undiscard", "Exercise", undiscardCondition);
      can("destroy", "Exercise");
    }

    if (user.hasGroup("Supervisor")) {
      const supervisorCondition = { supervisorId: String(user.id) };

      can("show", "User", supervisorCondition);
      can("startSupervision", "User", startSupervisionCondition);
      can("stopSupervision", "User", supervisorCondition);
      can("addRoutine", "User", supervisorCondition);

      can("index", "Patient");

      can("show", "Routine");
      can("discard", "Routine", {
        ...discardCondition,
        ...supervisorCondition
      });
      can("undiscard", "Routine", {
        ...undiscardCondition,
        ...supervisorCondition
      });
      can("destroy", "Routine", supervisorCondition);

      can("index", "Exercise");
    }
  });
}
