module ApiFlashcards
  module Api
    module V1
      class TrainerController < ApiFlashcards::Api::ApiController
        before_action :find_card, only: :review_card
        def index
          @cards = current_user.cards.pending || current_user.cards.repeating
          render json: @cards.map { |v| { id: v.id, translated_text: v.translated_text } }
        end

        def review_card
          check_result = @card.check_translation(user_translation)
          if check_result[:state] && check_result[:distance].zero?
            msg = "Right. Let's check next card."
          elsif check_result[:state]
            msg = "Oops! Your answer is correct, but you made a typo. Right translate: #{@card.original_text}, you typed: #{user_translation}"
          else
            msg = "Wrong! Try another card."
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
