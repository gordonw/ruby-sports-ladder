require 'Faker'
include Faker

7.times {
  Player.create( name: Name.name)
}