puts "Seeding classification exercises..."

DEFAULT_TIME = 1000

default_classification_exercises_data = Exercise.classification_exercise_goals.map do | goal |
  [ goal.gsub('_', ' ').capitalize, [goal, 'reposo'] ]
end.to_h

custom_classification_exercises_data = {
  'Caramelo': ['caramelo_arriba', 'caramelo_derecha', 'caramelo_abajo', 'caramelo_izquierda'],
  'Lengua en círulo': ['lengua_arriba', 'lengua_derecha', 'lengua_abajo', 'lengua_izquierda'],
  'Boca abierta lengua arriba y abajo': ['boca_abierta_lengua_abajo', 'boca_abierta_lengua_arriba'],
}

classification_exercises_data = default_classification_exercises_data.merge(custom_classification_exercises_data)

classification_exercises = []

classification_exercises_data.each do | exercise_name, steps |
  classification_exercises << Exercise.create(
    exercise_type: Exercise::EXERCISE_TYPE_CLASSIFICATION,
    name: exercise_name,
    description: "Use la cámara del celular y realize #{exercise_name.downcase}.",
    steps: steps.map{ |goal| { goal: goal, time: DEFAULT_TIME } }.to_json
  )
end
