require 'rails_helper'

RSpec.describe 'Autenticate', type: :api do
  let!(:user) { FactoryGirl.create(:user) }

  context 'not success authenticate' do
    it 'have\'t access to api' do
      basic_authorize(user.email, 'wrong')
      get api_v1_cards_path
      expect(last_response.status).to eq 401
    end
  end

  context 'success authenticate' do
    it 'have access to api' do
      basic_authorize(user.email, user.password)
      get api_v1_cards_path
      expect(last_response.status).to eq 200
    end
  end
end
