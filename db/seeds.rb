# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "Thái Thị Tiến",
             username: "thaitien",
             email: "thaithitien1997@gmail.com",
             password: "12345678",
             gender: 2,
             birthday: "25/06/1997",
             password_confirmation: "12345678")
User.create!(name: "Nguyen Ba Hung",
             username: "bahung",
             email: "hungpronguyen256@gmail.com",
             password: "12345678",
             gender: 1,
             birthday: "25/06/1997",
             password_confirmation: "12345678",
             admin: true)
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               username: "bahung-#{n}",
               email: email,
               password: password,
               gender: 1,
               birthday: "25/06/1997",
               password_confirmation: password)
end
