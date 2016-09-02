module ApiFlashcards
  module Api
    module V1
      class CardsController < ApiFlashcards::Api::ApiController
        def index
          @cards = current_user.cards.order('review_date')
          render json: @cards
        end

        def show
          @card = Card.find(params[:id])
          render json: @card
        end

        def create
          @card = current_user.cards.build(card_params)
          if @card.save
            render json: @card, status: :created
          else
            render json: { status: :bad_request, errors: @card.errors }
          end
        end

        private

        def card_params
          params.require(:card).permit(:original_text, :translated_text)
        end
      end
    end
  end
end
