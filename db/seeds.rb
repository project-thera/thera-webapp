# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

sysadmin = Group.create(name: Group::SYSADMIN)
admin = Group.create(name: Group::ADMIN)

users = User.create([
  {
    username: 'lucio.digiacomo',
    password: 'dev',
    email: 'daniffig@gmail.com',
    fullname: 'Lucio Di Giacomo Noack',
    groups: [sysadmin]
  },
  {
    username: 'matias.arrech',
    password: 'dev',
    email: 'matiasarrech@gmail.com',
    fullname: 'Matías Arrech',
    groups: [sysadmin]
  }
])