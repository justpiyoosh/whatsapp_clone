# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create some test users
User.create!(username: 'alice', password: 'password123', password_confirmation: 'password123')
User.create!(username: 'bob', password: 'password123', password_confirmation: 'password123')
User.create!(username: 'charlie', password: 'password123', password_confirmation: 'password123')
User.create!(username: 'diana', password: 'password123', password_confirmation: 'password123')

puts "Created test users: alice, bob, charlie, diana"
puts "All users have password: password123"
