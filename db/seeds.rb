# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create(email: "admin@projectdb", password: "narfzort", first_name: "Admin", last_name: "User", current_role: "admin") if User.find_by("email='admin@projectdb'").nil?
ApiUser.create(email: "api@projectdb", password: "changethis") if ApiUser.find_by("email='api@projectdb'").nil?

if ENV["RAILS_ENV"] == "development"
  santa = User.create(email: "santa@projectdb", password: "changethis", first_name: "Santa", last_name: "Claus")
  krampus = User.create(email: "krampus@projectdb", password: "changethis", first_name: "Krampus", last_name: "")

  first_project = Project.create(name: "Fancy Project", shorthandle: "fprj", description: "A project to deliver gifts to the kids", user: santa, custom_id: "1")
  second_project = Project.create(name: "Tune up SLH", shorthandle: "tuslh", description: "That deer needs some rims!", user: krampus, parent_id: first_project.id, custom_id: "2")

  Environment.create(name: "North Pole", shorthandle: "np", description: "cold", project: first_project)
  Environment.create(name: "South Pole", shorthandle: "sp", description: "a lot of penguins here", project: first_project)
  third_environment = Environment.create(name: "Toys r us", shorthandle: "tru", description: "just in case", project: second_project)

  Secret.create(name: "naughties", content: "Peer, Piep", environment: third_environment)
  Secret.create(name: "behaved", content: "Nils", environment: third_environment)

  amount = 1000
  for i in 1..amount do
    puts "at #{i} / #{amount}" if i % 100 == 0

    project = Project.create(name: "Project #{i}", shorthandle: "p#{i}", description: "#{i}", user: santa, custom_id: 1000 + i)
    environment = Environment.create(name: "Environment #{i}", shorthandle: "e#{i}", project_id: project.id)
    Secret.create(name: "Secret #{i}", content: "#{i}", environment_id: environment.id)
  end
end
