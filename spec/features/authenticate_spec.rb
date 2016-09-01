require 'rails_helper'

RSpec.describe 'Autenticate', type: :feature do

  let!(:user) { FactoryGirl.create(:user) }

  context 'not success authenticate' do
    it 'have\'t access to api' do
      page.driver.browser.basic_authorize(user.email, 'wrong')
      visit 'api_flashcards/api/v1/cards'
      expect(page.status_code).to eq 401
    end
  end

  context 'success authenticate' do
    it 'have access to api' do
      page.driver.browser.basic_authorize('example@email.com', 'qwerty123')
      visit 'api_flashcards/api/v1/cards'
      expect(page.status_code).to eq 200
    end
  end
end
