puts "Seeding users..."

USERS_COUNT = 20

MAX_CREDITS = 2000
MAX_ROBOTS = 100

def sysadmin_group
  Group.find_or_create_by(name: Group::SYSADMIN)
end

def admin_group
  Group.find_or_create_by(name: Group::ADMIN)
end

def supervisor_group
  Group.find_or_create_by(name: Group::SUPERVISOR)
end

def patient_group
  Group.find_or_create_by(name: Group::PATIENT)
end

def create_patients(type, count: 1, supervisor: nil, confirmed: true)
  patients = []

  count.times do |i|
    game_reward = GameReward.new(
      credits: rand(0..MAX_CREDITS),
      robots: rand(0..MAX_ROBOTS),
      current_robot: rand(0..GameReward::MAX_CURRENT_ROBOT)
    )

    patients << User.create(
      username: "paciente_#{type}_#{i}",
      password: 'dev',
      email: "paciente_#{type}_#{i}@thera.com.ar",
      fullname: Faker::Name.unique.name,
      file: Faker::Lorem.paragraph(sentence_count: 10, random_sentences_to_add: 10),
      game_reward: game_reward,
      confirmed_at: confirmed ? Faker::Time.backward(days: 30) : nil,
      supervisor: supervisor,
      groups: [patient_group]
    )
  end

  if count == 1
    return patients[0]
  end

  patients
end

def create_supervisors(type, count: 1)
  supervisors = []

  count.times do |i|
    supervisors << User.create(
      username: "supervisor_#{type}_#{i}",
      password: 'dev',
      email: "supervisor_#{type}_#{i}@thera.com.ar",
      fullname: Faker::Name.unique.name,
      confirmed_at: Faker::Time.backward(days: 30),
      groups: [supervisor_group]
    )
  end

  if count == 1
    return supervisors[0]
  end

  supervisors
end

users = User.create([
  {
    username: 'lucio.digiacomo',
    password: 'dev',
    email: 'daniffig@gmail.com',
    fullname: 'Lucio Di Giacomo Noack',
    confirmed_at: DateTime.now,
    groups: [sysadmin_group]
  },
  {
    username: 'matias.arrech',
    password: 'dev',
    email: 'matiasarrech@gmail.com',
    fullname: 'Matías Arrech',
    confirmed_at: DateTime.now,
    groups: [sysadmin_group]
  }
])

create_patients('sin_supervision', count: USERS_COUNT)
create_supervisors('sin_pacientes', count: USERS_COUNT)
# create_patients('sin_confirmar', count: USERS_COUNT, confirmed: false)
create_patients('sin_confirmar', count: USERS_COUNT, confirmed: true)

supervisor_with_patients = create_supervisors('con_pacientes')
create_patients('con_supervision', count: USERS_COUNT, supervisor: supervisor_with_patients)

User.create(
  username: 'paciente',
  password: 'dev',
  email: 'paciente@thera.com.ar',
  fullname: Faker::Name.unique.name,
  confirmed_at: Faker::Time.backward(days: 30),
  supervisor: supervisor_with_patients,
  groups: [patient_group]
)
