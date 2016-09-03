require 'rails_helper'

module ApiFlashcards
  module Api
    module V1
      RSpec.describe 'CardsController', type: :api do
        let!(:user) { FactoryGirl.create(:user) }
        let!(:cards) { FactoryGirl.create_list(:card, 3, user: user) }

        context 'get all user\'s cards' do
          before(:each) do
            basic_authorize(user.email, user.password)
            get '/api_flashcards/api/v1/cards'
          end

          it 'should have status ok' do
            expect(last_response.status).to eq 200
          end

          it 'should return list cards as json of size 3' do
            expect(last_response.body).to have_json_size(3)
          end
        end

        context 'show card' do
          let!(:card) { FactoryGirl.create(:card, user: user) }

          before(:each) do
            basic_authorize(user.email, user.password)
            get '/api_flashcards/api/v1/cards/4'
          end

          %w(id original_text translated_text review_date).each do |attr|
            it "contains #{attr}" do
              expect(last_response.body).to be_json_eql(card.send(attr.to_sym).to_json).at_path(attr)
            end
          end
        end

        context 'create card' do
          let(:attr) do
            { original_text: 'car', translated_text: 'машина' }
          end

          it 'have status created' do
            basic_authorize(user.email, user.password)
            post '/api_flashcards/api/v1/cards',  card: attr
            expect(last_response.status).to eq 201
          end
        end
      end
    end
  end
end
