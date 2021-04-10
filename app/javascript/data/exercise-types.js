import classificationLabels from "./labels";

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

export const classificationGoals = Object.fromEntries(
  classificationLabels.map(label => {
    return [label, translateLabel(label)];
  })
);

export const blowGoals = {
  [true]: "Soplar",
  [false]: "Sin soplar"
};

export const exerciseTypeGoalOptions = {
  blow: objectToOptions(blowGoals),
  speech: null,
  classification: objectToOptions(classificationGoals)
};
