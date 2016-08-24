module ApiFlashcards
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :authenticate

    def authenticate
      authenticate_or_request_with_http_basic do |email, password|
        begin
          user = User.find_by(email: email)
          user && user.password == password
        rescue Encoding::UndefinedConversionError
          # redirect_to root_path
        end
      end
    end
  end
end
