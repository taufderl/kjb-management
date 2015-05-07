# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Account.delete_all
Account.create([{name: 'Lagerkasse Bar'}, {name: 'Lagerkasse Girokonto'}, {name: 'Gruppenleiterkasse'}])

User.delete_all
User.create([{name: 'Lena'}, {name: 'Johannes'}])

Tent.delete_all

(1..12).each do |no|
  Tent.create(number: no)
end
