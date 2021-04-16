puts "Seeding speech exercises..."

speech_exercise_data = [
  "perro",
  "gato",
  "cocodrilo",
  "serpiente",
  "jirafa",
  "ratón",
  "murcielago",
  "pangolín",
  "auto rojo",
  "camión verde",
  "cha cha cha",
  "campera marrón"
]

spech_exercises = []

speech_exercise_data.each do | sentence |
  spech_exercises << Exercise.create(
    exercise_type: Exercise::EXERCISE_TYPE_SPEECH,
    name: sentence.capitalize,
    description: "Presione el bóton y pronuncie \"#{sentence.capitalize()}\".",
    steps: [
      {
        goal: sentence
      },
    ].to_json
  )
end