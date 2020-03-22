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
Testimonial.create(name: 'Rahun Kanchan', text: 'Very nice place to Party, Birthday and other functions')
categories = [
  {
    "const": "one_day_trip",
    "title": "One Day Trip"
  },
  {
    "const": "school_trip",
    "title": "School Trip"
  },
  {
    "const": "hurda_party",
    "title": "Hurda Party"
  },
  {
    "const": "organic_farming",
    "title": "Organic Farming"
  },
  {
    "const": "wedding",
    "title": "Wedding"
  },
  {
    "const": "baby_shower",
    "title": "Baby Shower"
  },
  {
    "const": "birthday_party",
    "title": "Birthday Party"
  },
  {
    "const": "gatetogether",
    "title": "Gatetogether"
  },
  {
    "const": "indoor_games",
    "title": "Indoor Games"
  },
  {
    "const": "outdoor_games",
    "title": "Outdoor Games"
  },
  {
    "const": "adventure_game",
    "title": "Adventure Game"
  },
  {
    "const": "rain_dance",
    "title": "Rain Dance"
  },
  {
    "const": "waterfall",
    "title": "Waterfall"
  },
  {
    "const": "swimming_pool",
    "title": "Swimming Pool"
  },
  {
    "const": "bicycle_ride",
    "title": "Bicycle Ride"
  },
  {
    "const": "bullock_cart_ride",
    "title": "Bullock Cart Ride"
  },
  {
    "const": "tractor_ride",
    "title": "Tractor Ride"
  },
  {
    "const": "horse_ride",
    "title": "Horse Ride"
  },
  {
    "const": "veg",
    "title": "Veg"
  },
  {
    "const": "non_veg",
    "title": "Non-Veg"
  },
  {
    "const": "boating",
    "title": "Boating"
  },
  {
    "const": "night_camping",
    "title": "Night Camping"
  },
  {
    "const": "sunset_point",
    "title": "Sunset Point"
  },
  {
    "const": "sunrise_point",
    "title": "Sunrise Point"
  },
  {
    "const": "near_dam",
    "title": "Near Dam"
  },
  {
    "const": "old_is_gold",
    "title": "Old is Gold"
  },
  {
    "const": "farm_house",
    "title": "FarmHouse"
  },
  {
    "const": "farming_experience",
    "title": "Farming Experience"
  },
  {
    "const": "agro_farm_education",
    "title": "Agro Farm Education"
  },
  {
    "const": "senior_citizen_day",
    "title": "Senior Citizen Day"
  }
]
Category.create(categories)
ApiToken.create(token: '2e1f85f04fe0d55f388465972f5dc47f')
