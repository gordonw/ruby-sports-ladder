require_relative('../spec_helper_capybara')

describe 'Pool Ladder Display Page', :type => :feature do

  def create_test_players(number_of_players)
    number_of_players.times {
      Player.create( name: Faker.name)
    }
  end

  it 'should display a title' do
    visit '/'
    expect(page).to have_title 'Pool Ladder'
  end

  it 'should display a page heading' do
    visit '/'
    expect(page).to have_content('Pool Ladder')
  end

  it 'should display a list of players' do
    create_test_players(4)

    visit '/'
    expect(page).to have_selector('#playerList li', :count => 4)
  end

  it 'should be possible to add a new player' do
    create_test_players(2)
    visit '/'
    new_player_name = Faker.name
    fill_in 'playerName', :with => new_player_name
    click_button('New Player')
    expect(page).to have_selector('#playerList li', :count => 3)
    expect(page).to have_content new_player_name
  end
end

