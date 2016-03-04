# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if User.count.zero?
  user = User.new email: 'admin@bitbillers.com', password: 'admin1234'
  user.save(validate: false)
end

if Role.count.zero?
  Role.default_role
end

User.find_by_email('admin@bitbillers.com').role_ids = Role.first.id

if BitCoinPrice.count.zero?
  BitCoinPrice.create(price: 319.96)
end

if AppConfiguration.count.zero?
  AppConfiguration.create!
end