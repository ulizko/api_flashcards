require 'rails_helper'

module ApiFlashcards
  module Api
    module V1
      RSpec.describe 'TrainerController', type: :api do
        let!(:user) { FactoryGirl.create(:user) }
        let!(:cards) { FactoryGirl.create_list(:card, 4, user: user) }

        context 'show not reviewed cards' do
          before do
            basic_authorize(user.email, user.password)
            get '/api_flashcards/api/v1/trainer'
          end

          it 'should have status ok' do
            expect(last_response.status).to eq 200
          end

          %w(id translated_text).each do |attr|
            it "contains #{attr}" do
              expect(last_response.body).to be_json_eql(cards.first.send(attr.to_sym).to_json).at_path("0/#{attr}")
            end
          end

          it 'don\'t contains original_text' do
            expect(JSON.parse(last_response.body).first).not_to include('original_text')
          end
        end
      end
    end
  end
end
