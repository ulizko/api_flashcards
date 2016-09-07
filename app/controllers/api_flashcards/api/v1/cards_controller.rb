module ApiFlashcards
  module Api
    module V1
      class CardsController < ApiFlashcards::Api::ApiController
        # Handles a GET request /api/v1/cards
        # Show all cards current user ordered by review date
        #
        # @return [JSON] list of cards.
        def index
          @cards = current_user.cards.order('review_date')
          render json: @cards
        end

        # Handles a GET request /api/v1/cards/:id
        # Show one card
        # @param id [Integer] card :id
        # @return [JSON] information about card.
        def show
          @card = Card.find(params[:id])
          render json: @card
        end

        # Handles a POST request /api/v1/card
        # Create card
        # @param original_text [String], translated_text [String]
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
