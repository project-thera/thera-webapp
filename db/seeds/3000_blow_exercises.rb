puts "Seeding blow exercises..."

blow_exercises_data = [1000, 2000, 5000, 8000, 10000]
blow_exercises = []

blow_exercises_data.each do | time |
  blow_exercises << Exercise.create(
    exercise_type: Exercise::EXERCISE_TYPE_BLOW,
    name: "Soplido #{time/1000.ceil} segundos",
    description: "Acerque el celular a su cara y sople durante #{time/1000.ceil} segundos.",
    steps: [
      {
        goal: Exercise.blow_exercise_goals[0],
        time: time
      },
      {
        goal: Exercise.blow_exercise_goals[1],
        time: time
      }
    ].to_json
  )
end