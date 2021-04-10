function classificationGoals(goals) {
  return Object.fromEntries(
    goals.map(label => {
      return [label, translateLabel(label)];
    })
  );
}

function blowGoals() {
  return {
    [true]: "Soplar",
    [false]: "Sin soplar"
  };
}

export function exerciseTypeAndGoalsOptions(serverParameters) {
  const { exercise_types, exercise_type_goals } = serverParameters;

  const classificationGoalsArray = exercise_type_goals.find(
    element => Object.keys(element)[0] == "classification"
  )["classification"];

  return {
    exerciseTypeOptions: objectToOptions(exercise_types),
    exerciseTypeGoalOptions: {
      classification: objectToOptions(
        classificationGoals(classificationGoalsArray)
      ),
      blow: objectToOptions(blowGoals()),
      speech: null
    }
  };
}

function capitalize(s) {
  return s.charAt(0).toUpperCase() + s.slice(1);
}

function translateLabel(label) {
  return capitalize(label.replaceAll("_", " "));
}

export function objectToOptions(object) {
  return Object.keys(object).map(v => {
    return { value: v, text: object[v] };
  });
}
