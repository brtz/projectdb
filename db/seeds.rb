# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

initial_user = User.create(email: 'admin@app.local', password: 'narfzort', first_name: 'Admin', last_name: 'User')

first_project = Project.create(name: 'Fancy Project', shorthandle: 'fprj', description: 'A project to deliver gifts to the kids', contact_person: 'Santa Claus')
second_project = Project.create(name: 'Tune up SLH', shorthandle: 'tuslh', description: 'That deer needs some rims!', contact_person: 'Krampus', parent_id: first_project.id)
