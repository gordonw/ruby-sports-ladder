require 'spec_helper_capybara'
include Faker

feature 'Sports Ladder Ladder Page' do

  def create_existing_players numberOfPlayers
    numberOfPlayers.times do |rank|
      Player.create(name: Name.name, rank: rank)
    end
  end

  def create_player_with_rank(rank)
    Player.create(name: Name.name, rank: rank)
  end

  it 'should display a title' do
    visit '/'
    expect(page).to have_title 'Pool Ladder'
  end

  it 'should display a page heading' do
    visit '/'
    expect(page).to have_selector('#pageHeading', :text => 'Pool Ladder')
  end

  it 'should display a list of players ordered by rank' do
    player1 = create_player_with_rank(3)
    player2 = create_player_with_rank(4)
    player3 = create_player_with_rank(1)
    player4 = create_player_with_rank(2)

    visit '/'

    players = page.all('#playerList li')

    expect(players[0].text).to eq player3.name
    expect(players[1].text).to eq player4.name
    expect(players[2].text).to eq player1.name
    expect(players[3].text).to eq player2.name
  end

  it 'should be possible to add a new player to the end of the ladder' do
    create_existing_players(2)
    visit '/'

    new_player_name = Name.name

    fill_in 'playerName', :with => new_player_name
    click_button('New Player')
    expect(page).to have_selector('#playerList li', :count => 3)

    expect(page.all('#playerList li').last.text).to eq new_player_name
  end
end

