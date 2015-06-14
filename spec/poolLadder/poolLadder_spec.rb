require_relative('../spec_helper_capybara')

describe 'Pool Ladder Display Page', :type => :feature do

  it 'should display a title' do
    visit '/'
    expect(page).to have_title 'Pool Ladder'
  end

  it 'should display a page heading' do
    visit '/'
    expect(page).to have_content('Pool Ladder')
  end

  it 'should be possible to add a new player' do
    visit '/'
    fill_in 'playerName', :with => 'Sam Smith'
    click_button('New Player')
    expect(page).to have_content('Sam Smith')
  end
end

