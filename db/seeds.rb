# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create(
  email: 'admin@example.com',
  password: '12345678',
  password_confirmation: '12345678',
  first_name: 'Demo',
  last_name: 'Admin'
)
User.create(
  email: 'user@example.com',
  password: '12345678',
  password_confirmation: '12345678',
  first_name: 'Demo',
  last_name: 'User'
)
categories = ['Baby Shower', 'Birthday Party', 'Engagement', 'Wedding', 'School Trip']
Category.create(categories.map {|c| { title: c }})
Testimonial.create(name: 'Rahun Kanchan', text: 'Very nice place to Party, Birthday and other functions')