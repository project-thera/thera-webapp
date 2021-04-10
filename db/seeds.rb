# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

sysadmin = Group.create(name: Group::SYSADMIN)
admin = Group.create(name: Group::ADMIN)
supervisor = Group.create(name: Group::SUPERVISOR)
patient = Group.create(name: Group::PATIENT)

users = User.create([
  {
    username: 'lucio.digiacomo',
    password: 'dev',
    email: 'daniffig@gmail.com',
    fullname: 'Lucio Di Giacomo Noack',
    confirmed_at: DateTime.now,
    groups: [sysadmin]
  },
  {
    username: 'matias.arrech',
    password: 'dev',
    email: 'matiasarrech@gmail.com',
    fullname: 'Matías Arrech',
    confirmed_at: DateTime.now,
    groups: [sysadmin]
  }
])

supervisor1 = User.create(
  username: 'supervisor1',
  password: 'dev',
  email: 'supervisor1@thera.com.ar',
  fullname: 'Sheev Palpatine',
  confirmed_at: DateTime.now,
  groups: [supervisor]
)

supervisor2 = User.create(
  username: 'supervisor2',
  password: 'dev',
  email: 'supervisor2@thera.com.ar',
  fullname: 'Obi-Wan Kenobi',
  confirmed_at: DateTime.now,
  groups: [supervisor]
)

patient1 = User.create(
  username: 'paciente1',
  password: 'dev',
  email: 'paciente1@thera.com.ar',
  fullname: 'Anakin Skywalker',
  confirmed_at: DateTime.now,
  groups: [patient],
  supervisor: supervisor1
)

patient2 = User.create(
  username: 'paciente2',
  password: 'dev',
  email: 'paciente2@thera.com.ar',
  fullname: 'Luke Skywalker',
  confirmed_at: DateTime.now,
  groups: [patient],
  supervisor: supervisor2
)

patient3 = User.create(
  username: 'paciente3',
  password: 'dev',
  email: 'paciente3@thera.com.ar',
  fullname: 'Leia Organa',
  confirmed_at: DateTime.now,
  groups: [patient],
  supervisor: supervisor2
)

routine1 = Routine.create(
  supervisor: supervisor1,
  patient: patient1
)

routine2 = Routine.create(
  supervisor: supervisor1,
  patient: patient1
)

exercise_types = Exercise.exercise_types.keys

exercises_count = 50

(1..exercises_count).each do |i|
  exercise = Exercise.create(
    name: "Ejercicio ##{i}",
    exercise_type: exercise_types[i % exercise_types.length]
  )
end

(exercises_count..(exercises_count + 10)).each do |i|
  exercise = Exercise.create(
    name: "Ejercicio ##{i}",
    exercise_type: exercise_types[i % exercise_types.length]
  )

  routine1.routine_exercises.create(
    exercise: exercise
  )

  routine2.routine_exercises.create(
    exercise: exercise
  )
end
