require 'rails_helper'

module ApiFlashcards
  module Api
    module V1
      RSpec.describe 'TrainerController', type: :api do
        let!(:user) { FactoryGirl.create(:user) }
        let!(:cards) { FactoryGirl.create_list(:card, 3, user: user) }
        
        context 'show not reviewed cards' do
          before(:each) do
            basic_authorize(user.email, user.password)
            get '/api_flashcards/api/v1/cards'
          end
        end
      end
    end
  end
end