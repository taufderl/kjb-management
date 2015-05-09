# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ScoutConsumption.delete_all


Account.delete_all
Account.create([{name: 'Lagerkasse Bar'}, {name: 'Lagerkasse Girokonto'}, {name: 'Gruppenleiterkasse'}])

User.delete_all
User.create([{name: 'Lena'}, {name: 'Johannes'}])

Tent.delete_all
(1..12).each do |no|
  Tent.create(number: no)
end

Child.delete_all
(1..50).each do |no|
  Child.create({first_name: "child_#{no}", last_name: "child_#{no}", birthday: Date.today, tent: Tent.all[rand(0..11)]})  
end

Scout.delete_all
(1..15).each do |no|
  Scout.create({first_name: "GL_#{no}", last_name: "GL_#{no}", birthday: Date.today - 21.years, tent: Tent.all[rand(0..11)]})  
end

Setting.delete_all
Setting.create([ 
    {key: :start_date, type: :date, value: "2015-08-17"},
    {key: :end_date, type: :date, value: "2015-09-02"}
])

