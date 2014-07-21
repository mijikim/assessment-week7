require 'spec_helper'

feature 'Homepage' do
  scenario 'Shows the welcome message' do
    visit '/'

    expect(page).to have_content 'Welcome!'
  end

  scenario 'Shows user\'s message' do
    visit '/'
    fill_in 'username', with: 'Mi Ji'
    fill_in 'message', with: 'Hello!'
    click_button 'Add Message'
    expect(page).to have_content("Hello!")
    expect(page).to have_content("Mi Ji")
  end

end