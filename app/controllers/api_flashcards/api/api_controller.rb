module ApiFlashcards
  module Api
    class ApiController < ActionController::API
      include ActionController::HttpAuthentication::Basic::ControllerMethods
      include ActionController::MimeResponds
      include AbstractController::Translation

      attr_reader :current_user
      before_action :authenticate

      private

      def authenticate
        authenticate_or_request_with_http_basic do |email, password|
          begin
            @user = User.find_by(email: email)
            @user && @user.password == password
          rescue Encoding::UndefinedConversionError
            # redirect_to root_path
          end
        end
      end

      def current_user
        @current_user ||= @user
      end
    end
  end
end
