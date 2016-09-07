require 'rails_helper'

module ApiFlashcards
  module Api
    module V1
      RSpec.describe 'TrainerController', type: :api do
        let!(:user) { FactoryGirl.create(:user) }
        let!(:cards) { FactoryGirl.create_list(:card, 4, user: user) }

        describe 'show not reviewed cards' do
          before do
            basic_authorize(user.email, user.password)
            get api_v1_trainer_path
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

        describe 'review card' do
          let(:card) { FactoryGirl.create(:card, user: user) }
          let(:attr) do
            { id: card.id, user_translation: card.original_text }
          end

          before { basic_authorize(user.email, user.password) }

          it 'should return right message' do
            put api_v1_review_card_path, attr
            message = {message: I18n.t('api_flashcards.api.v1.trainer.review_card.right')}.to_json
            expect(last_response.body).to be_json_eql(message)
          end

          it 'should return oops message' do
            put api_v1_review_card_path, attr.merge(user_translation: 'house')
            message = {message: I18n.t('api_flashcards.api.v1.trainer.review_card.oops',
                                       original_text: card.original_text,
                                       user_translation: 'house')}.to_json
            expect(last_response.body).to be_json_eql(message)
          end

          it 'should return wrong message' do
            put api_v1_review_card_path, attr.merge(user_translation: 'hous')
            message = {message: I18n.t('api_flashcards.api.v1.trainer.review_card.wrong')}.to_json
            expect(last_response.body).to be_json_eql(message)
          end
        end
      end
    end
  end
end
