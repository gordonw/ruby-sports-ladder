require 'spec_helper_capybara'
include Faker

def show_ladder
  visit "/ladder/#{@ladder.slug}"
end

def create_existing_players numberOfPlayers
  numberOfPlayers.times do |position|
    Player.create(name: Name.name, position: position, ladder_id: @ladder.id)
  end
end

def create_player_with_position(position)
  Player.create(name: Name.name, position: position, ladder_id: @ladder.id)
end


feature 'Sports Ladder Ladder Page' do


  before(:each) do
    @ladder = Ladder.create(
        slug: Lorem.characters(5),
        name: "#{Company.name} Sports Ladder",
        description: Lorem.sentence(6)
    )
  end

  
  it 'should display a page heading' do
    show_ladder
    expect(page).to have_selector('#pageHeading', :text => @ladder.name)
  end


  it 'should display a list of players ordered by position' do
    player1 = create_player_with_position(3)
    player2 = create_player_with_position(4)
    player3 = create_player_with_position(1)
    player4 = create_player_with_position(2)

    show_ladder

    players = page.all('#playerList li')

    expect(players[0].text).to eq player3.name
    expect(players[1].text).to eq player4.name
    expect(players[2].text).to eq player1.name
    expect(players[3].text).to eq player2.name
  end


  it 'should be possible to add a new player to the ladder' do
    create_existing_players(2)
    show_ladder

    new_player_name = Name.name

    fill_in 'playerName', :with => new_player_name
    click_button('New Player')
    expect(page).to have_selector('#playerList li', :count => 3)
  end


  it 'should be possible to move a player', :js => true do

    player1 = create_player_with_position(1)
    player2 = create_player_with_position(2)
    player3 = create_player_with_position(3)
    player4 = create_player_with_position(4)

    show_ladder

    element1 = page.find('#playerList li', :text => player1.name)
    element4 = page.find('#playerList li', :text => player4.name)

    element4.click
    element1.click

    reordered_players = page.all('#playerList li')

    expect(reordered_players[0].text).to eq player4.name
    expect(reordered_players[1].text).to eq player1.name
    expect(reordered_players[2].text).to eq player2.name
    expect(reordered_players[3].text).to eq player3.name
  end

end

