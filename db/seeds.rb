# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ScoutConsumption.delete_all
ChildConsumption.delete_all
Booking.delete_all

Account.delete_all
MainAccount.delete_all
ScoutAccount.delete_all
ChildAccount.delete_all

MainAccount.create([{name: 'Lagerkasse Bar'}, {name: 'Gruppenleiterkasse Girokonto'}, {name: 'Gruppenleiterkasse'}, {name: 'Kinderkasse'}])

User.delete_all
User.create([{name: 'Johannes'}, {name: 'Lena'}, {name: 'Gast'}])

Tent.delete_all
Scout.delete_all
Child.delete_all

Setting.delete_all
Setting.create([ 
    {key: :start_date, type: :date, value: "2015-08-17"},
    {key: :end_date, type: :date, value: "2015-09-02"}
])

