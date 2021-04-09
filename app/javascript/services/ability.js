import { defineAbility } from "@casl/ability";

export default function defineAbilityFor(user) {
  return defineAbility(can => {
    const discardCondition = { discarded: false };
    const undiscardCondition = { discarded: true };

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

      can("index", "Patient");
      can("show", "Patient");
      can("addRoutine", "Patient");

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
      can("index", "Patient");
      can("show", "Patient");
      can("addRoutine", "Patient");

      const routineSupervisorCondition = { supervisor_id: user.id };

      can("show", "Routine");
      can("discard", "Routine", {
        ...discardCondition,
        ...routineSupervisorCondition
      });
      can("undiscard", "Routine", {
        ...undiscardCondition,
        ...routineSupervisorCondition
      });
      can("destroy", "Routine", routineSupervisorCondition);

      can("show", "User");
      can("addRoutine", "User");

      can("index", "Exercise");
    }
  });
}
