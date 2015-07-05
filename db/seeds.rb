require 'Faker'
include Faker

sports = %w(Snooker Pool Golf Chess)

8.times {
  players = []
  rand(18).times {
    players << Player.create(name: Name.name)
  }

  Ladder.create(slug: Lorem.characters(5),
                name: "#{Company.name} #{sports.sample} Ladder",
                description: Lorem.sentence(6),
                players: players
  )
}
