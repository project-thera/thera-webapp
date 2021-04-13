puts "Seeding routines..."

ROUTINES_COUNT = 10
ROUTINE_INTENTS_COUNT = 10
ROUTINE_EXERCISES_COUNT = 10

def random_exercises(count: 1)
  Exercise.order('RAND()').limit(rand(1..count))
end

def random_routine_intents(exercises, count: 1)
  rand(1..count).times.collect do
    RoutineIntent.new(
      finished_at: Faker::Time.backward(days: 30),
      routine_intent_exercises: exercises.map { | exercise |
        RoutineIntentExercise.new(
          exercise: exercise,
          status: rand(RoutineIntentExercise.statuses.count)
        )
      }
    )
  end
end

def generate_routines(
  patient,
  routines_count: 1,
  routine_exercises_count: 1,
  routine_intents_count: 1
)
  rand(1..routines_count).times do
    exercises = random_exercises(count: routine_exercises_count)

    Routine.create(
      supervisor: patient.supervisor,
      patient: patient,
      routine_exercises: exercises.map{ | exercise | RoutineExercise.new(exercise: exercise) },
      routine_intents: random_routine_intents(exercises, count: routine_intents_count),
      daily_limit: rand(1..3)
    )
  end
end

User.patients_with_supervisor.includes(:supervisor).each do | patient |
  generate_routines(
    patient,
    routines_count: ROUTINES_COUNT,
    routine_exercises_count: ROUTINE_EXERCISES_COUNT,
    routine_intents_count: ROUTINE_INTENTS_COUNT
  )
end

# routine2 = Routine.create(
#   supervisor: supervisor_with_patients,
#   patient: supervisor_with_patients.patients.first
# )

# exercise_types = Exercise.exercise_types.keys

# exercises_count = 20

# (1..exercises_count).each do |i|
#   exercise = Exercise.create(
#     name: "Ejercicio ##{i}",
#     exercise_type: exercise_types[i % exercise_types.length]
#   )
# end

# (exercises_count..(exercises_count + 10)).each do |i|
#   exercise = Exercise.create(
#     name: "Ejercicio ##{i}",
#     exercise_type: exercise_types[i % exercise_types.length]
#   )

#   routine1.routine_exercises.create(
#     exercise: exercise
#   )

#   routineInten1 = RoutineIntent.create(
#     routine: routine1,
#     finished_at: DateTime.now + i.minutes,
#     routine_intent_exercises: [RoutineIntentExercise.new(exercise: exercise)]
#   )

#   routine2.routine_exercises.create(
#     exercise: exercise
#   )

#   RoutineIntent.create(
#     routine: routine2,
#     finished_at: DateTime.now + (i + 1).minutes,
#     routine_intent_exercises: [RoutineIntentExercise.new(exercise: exercise)]
#   )
# end
