require 'rails_helper'

feature 'reviewing' do
  context 'at review submit' do

    before do
      sign_up
      add_restaurant
    end

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'So-so'
    select '3', from: 'Rating'
    click_button 'Leave review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'So-so'
  end

  scenario 'user can only leave one review per restaurant' do
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'So-so'
    select '3', from: 'Rating'
    click_button 'Leave review'
    expect(page).not_to have_content('Review KFC')
  end
end
end
