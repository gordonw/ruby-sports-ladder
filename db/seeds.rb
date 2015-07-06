require 'Faker'
include Faker

sports = %w(Snooker Pool Golf Chess)

8.times {
  ladder = Ladder.create(
      slug: Lorem.characters(5),
      name: "#{Company.name} #{sports.sample} Ladder",
      description: Lorem.sentence(6)
  )

  rand(18).times {
    Player.create(name: Name.name, ladder_id: ladder.id)
  }

}
