# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

if ENV["RAILS_ENV"] == "development"
    admin_user = User.create(email: 'admin@projectdb', password: 'narfzort', first_name: 'Admin', last_name: 'User')
    api_user = User.create(email: 'api@projectdb', password: 'changethis', first_name: 'Api', last_name: 'User')
    santa = User.create(email: 'santa@projectdb', password: 'changethis', first_name: 'Santa', last_name: 'Claus')
    krampus = User.create(email: 'krampus@projectdb', password: 'changethis', first_name: 'Krampus', last_name: '')

    first_project = Project.create(name: 'Fancy Project', shorthandle: 'fprj', description: 'A project to deliver gifts to the kids', user: santa, custom_id: '1')
    second_project = Project.create(name: 'Tune up SLH', shorthandle: 'tuslh', description: 'That deer needs some rims!', user: krampus, parent_id: first_project.id, custom_id: '2')

    first_environment = Environment.create(name: 'North Pole', shorthandle: 'np', description: 'cold', project: first_project)
    second_environment = Environment.create(name: 'South Pole', shorthandle: 'sp', description: 'a lot of penguins here', project: first_project)
    third_environment = Environment.create(name: 'Toys r us', shorthandle: 'tru', description: 'just in case', project: second_project)

    naughty_list = Secret.create(name: 'naughties', content: 'Peer, Piep', environment: third_environment)
    behaved_list = Secret.create(name: 'behaved', content: 'Nils', environment: third_environment)
end
