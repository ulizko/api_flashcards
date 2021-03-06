module ApiFlashcards
  module Api
    module V1
      class TrainerController < ApiFlashcards::Api::ApiController
        before_action :find_card, only: :review_card

        # Handles a GET request /api/v1/trainer
        # Show all not reviewed cards ordered by id
        #
        # @return [JSON] list of cards contains only id and translated text
        def index
          @cards = current_user.cards.pending || current_user.cards.repeating
          render json: @cards.sort_by(&:id), each_serializer: TrainerSerializer
        end

        # Handles a PUT request /api/v1/review_card
        # Check the correctness of the translation of the user.
        # @param id [Integer], user_translation [String]
        # @return [JSON] list of cards contains only id and translated text
        def review_card
          check_result = @card.check_translation(user_translation)
          msg = if check_result[:state] && check_result[:distance].zero?
                  t('.right')
                elsif check_result[:state]
                  t('.oops', original_text: @card.original_text, user_translation: user_translation)
                else
                  t('.wrong')
                end
          render json: { message: msg }, status: :ok
        end

        private

        def user_translation
          params[:user_translation]
        end

        def find_card
          @card = Card.find(params[:id])
        end
      end
    end
  end
end
