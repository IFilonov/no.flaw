# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Staff.create!(email: 'admin@admin.com', password: 'password', password_confirmation: 'password')
female = Female.create!(username: 'female', nickname: 'female_nickname', password: 'password', password_confirmation: 'password')
male = Male.create!(username: 'male', nickname: 'male_nickname', password: 'password', password_confirmation: 'password', female: female)
Pair.create!(male: male, female: female)
