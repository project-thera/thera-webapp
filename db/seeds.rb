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
  username: 'patient1',
  password: 'dev',
  email: 'patient1@thera.com.ar',
  fullname: 'Anakin Skywalker',
  confirmed_at: DateTime.now,
  groups: [supervisor],
  supervisor: supervisor1
)

patient2 = User.create(
  username: 'patient2',
  password: 'dev',
  email: 'patient2@thera.com.ar',
  fullname: 'Luke Skywalker',
  confirmed_at: DateTime.now,
  groups: [supervisor],
  supervisor: supervisor2
)

patient3 = User.create(
  username: 'patient3',
  password: 'dev',
  email: 'patient3@thera.com.ar',
  fullname: 'Leia Organa',
  confirmed_at: DateTime.now,
  groups: [supervisor],
  supervisor: supervisor2
)

(1..100).each do |i|
  Exercise.create(
    name: "Exercise ##{i}",
    klass_name: "Exercise#{i}Class"
  )
end

routine1 = Routine.create(
  supervisor: supervisor1,
  patient: patient1
)

routine1.routine_exercises.create(
  exercise: Exercise.first
)