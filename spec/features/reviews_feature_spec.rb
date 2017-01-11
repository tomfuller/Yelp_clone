require 'rails_helper'

feature 'reviewing' do

  scenario 'allows users to leave a review using a form' do
    sign_up
    add_restaurant
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'So-so'
    select '3', from: 'Rating'
    click_button 'Leave review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'So-so'
  end
end
