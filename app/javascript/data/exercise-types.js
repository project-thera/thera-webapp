function translateLabels(goals) {
  if (!goals) return null;

  return Object.fromEntries(
    goals.map(label => {
      return [label, translateLabel(label)];
    })
  );
}

export function exerciseTypeAndGoalsOptions(serverParameters) {
  const {
    exercise_types,
    exercise_type_goals,
    exercise_type_step_fields
  } = serverParameters;

  const exerciseTypeGoalOptions = Object.fromEntries(
    exercise_type_goals.map(function(element) {
      return [
        Object.keys(element)[0],
        objectToOptions(translateLabels(element[Object.keys(element)[0]]))
      ];
    })
  );

  return {
    exerciseTypeOptions: objectToOptions(exercise_types),
    exerciseTypeGoalOptions,
    exerciseTypeStepFields: exercise_type_step_fields
  };
}

function capitalize(s) {
  return s.charAt(0).toUpperCase() + s.slice(1);
}

function translateLabel(label) {
  return capitalize(label.replaceAll("_", " "));
}

export function objectToOptions(object) {
  if (!object) return null;

  return Object.keys(object).map(v => {
    return { value: v, text: object[v] };
  });
}
