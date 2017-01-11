require 'rails_helper'
require_relative './web_helper.rb'
feature 'restaurants' do

  context 'when user is not present' do
    scenario 'it should take us to login page' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      expect(current_path).to eq '/users/sign_in'
    end
  end

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      sign_up
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

    context 'restaurants have been added' do
      before do
        Restaurant.create(name: 'KFC')
        sign_up
      end

      scenario 'display restaurants' do
        visit '/restaurants'
        expect(page).to have_content 'KFC'
        expect(page).not_to have_content 'No restaurants yet'
      end
    end

    context 'creating restaurants' do
      scenario 'prompts users to fill out a form then displays the new restaurant' do
        sign_up
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'KFC'
        click_button 'Create Restaurant'
        expect(page).to have_content 'KFC'
        expect(current_path).to eq '/restaurants'
      end

      context 'an invalid restaurant' do
        scenario 'does not let you submit a name that is too short' do
          sign_up
          visit '/restaurants'
          click_link 'Add a restaurant'
          fill_in 'Name', with: 'kf'
          click_button 'Create Restaurant'
          expect(page).not_to have_css 'h2', text: 'kf'
          expect(page).to have_content 'error'
        end
      end
    end

    context 'viewing restaurants' do

      let!(:kfc){Restaurant.create(name: 'KFC')}

      scenario 'lets a user view a restaurant' do
        sign_up
        visit '/restaurants'
        click_link 'KFC'
        expect(page).to have_content 'KFC'
        expect(current_path).to eq "/restaurants/#{kfc.id}"
      end
    end

    context 'editing restaurants' do
      before { Restaurant.create name: 'KFC', description: 'Deep fried goodness', id: 1 }
      scenario 'let a user edit a restaurant' do
        sign_up
        visit '/restaurants'
        click_link 'Edit KFC'
        fill_in 'Name', with: 'Kentucky Fried Chicken'
        fill_in 'Description', with: 'Deep fried goodness'
        click_button 'Update Restaurant'
        click_link 'Kentucky Fried Chicken'
        expect(page).to have_content 'Kentucky Fried Chicken'
        expect(page).to have_content 'Deep fried goodness'
        expect(current_path).to eq '/restaurants/1'
      end
    end

    context 'deleting restaurants' do
      before { Restaurant.create name: 'KFC', description: "Deep fried goodness"}

      scenario 'removes a restaurant when a user clisks a delete link' do
        sign_up
        visit '/restaurants'
        click_link 'Delete KFC'
        expect(page).not_to have_content 'KFC'
        expect(page).to have_content 'Restaurant deleted successfully'
      end
    end



end
