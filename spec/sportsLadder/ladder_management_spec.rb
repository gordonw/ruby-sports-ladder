require 'spec_helper_capybara'
include Faker

feature 'Sports Ladder Management Page' do

  def create_ladder slug, name, description = ''
    Ladder.create(slug: slug, name: name, description: description)
  end


  it 'should display a title' do
    visit '/'
    expect(page).to have_title 'Sports Ladder'
  end


  it 'should display a page heading' do
    visit '/'
    expect(page).to have_selector('#pageHeading', :text => 'Sports Ladder')
  end


  it 'should display a list of existing ladders ordered alphabetically' do
    second_ladder = create_ladder('slug1', 'B', 'Test ladder that is alphabetically second')
    third_ladder = create_ladder('slug1', 'C', 'Test ladder that is alphabetically third')
    first_ladder = create_ladder('slug1', 'A', 'Test ladder that is alphabetically first')

    visit '/'

    ladders = page.all('#ladderList li')

    expect(ladders[0].find('a').text).to eq first_ladder.name
    expect(ladders[0].find('span').text).to eq first_ladder.description

    expect(ladders[1].find('a').text).to eq second_ladder.name
    expect(ladders[1].find('span').text).to eq second_ladder.description

    expect(ladders[2].find('a').text).to eq third_ladder.name
    expect(ladders[2].find('span').text).to eq third_ladder.description
  end


  it 'should be possible to select a specific ladder to view' do
    player1 = Player.create(name: Name.name, position: 0)
    player2 = Player.create(name: Name.name, position: 1)

    puts player1.name
    puts player2.name

    ladder = Ladder.create(
        slug: 'ladder1', name: 'A sports ladder',
        players: [player1, player2]
    )

    visit '/'
    page.find('a').click

    expect(page).to have_title "Sports Ladder - #{ladder.name}"
    expect(page).to have_selector('#pageHeading', :text => ladder.name)

    players = page.all('#playerList li')
    puts players[0].text
    puts players[1].text

    expect(players[0].text).to eq player1.name
    expect(players[1].text).to eq player2.name
  end

end

