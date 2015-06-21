require 'spec_helper_capybara'

feature'Sports Ladder Ladder Page' do

  def create_existing_players(number_of_players)
    number_of_players.times {
      Player.create( name: Faker::Name.name)
    }
  end

  it 'should display a title' do
    visit '/'
    expect(page).to have_title 'Pool Ladder'
  end

  it 'should display a page heading' do
    visit '/'
    expect(page).to have_selector('#pageHeading', :text => 'Pool Ladder')
  end

  it 'should display a list of players' do
    create_existing_players(4)

    visit '/'
    expect(page).to have_selector('#playerList li', :count => 4)
  end

  it 'should be possible to add a new player' do
    create_existing_players(2)
    visit '/'
    new_player_name = Faker::Name.name
    fill_in 'playerName', :with => new_player_name
    click_button('New Player')
    expect(page).to have_selector('#playerList li', :count => 3)
    expect(page).to have_content new_player_name
  end
end

