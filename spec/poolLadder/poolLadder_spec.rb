require_relative('../spec_helper_capybara')

describe 'Pool Ladder Display Page', :type => :feature do

  def createTestPlayers(numberOfPlayers)
    numberOfPlayers.times {
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
    createTestPlayers(4)

    visit '/'
    expect(page).to have_selector('#playerList li', :count => 4)
  end

  it 'should be possible to add a new player' do
    createTestPlayers(2)
    visit '/'
    newPlayer = Faker.name
    fill_in 'playerName', :with => newPlayer
    click_button('New Player')
    expect(page).to have_selector('#playerList li', :count => 3)
    expect(page).to have_content newPlayer
  end
end

