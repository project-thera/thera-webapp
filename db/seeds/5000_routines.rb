puts "Seeding routines..."

ROUTINES_COUNT = 20
ROUTINE_INTENTS_COUNT = 20
ROUTINE_EXERCISES_COUNT = 20

def random_exercises(count: 1)
  Exercise.order('RAND()').limit(rand(1..count))
end

def random_routine_intents(exercises, count: 1)
  rand(1..count).times.collect do
    started_at = Faker::Time.backward(days: 90)

    RoutineIntent.new(
      started_at: started_at,
      finished_at: [true, false].sample ? started_at + 5.minutes : nil,
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
      daily_limit: rand(1..3),
      discarded_at: [true, false].sample ? Faker::Time.backward(days: 30) : nil
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
