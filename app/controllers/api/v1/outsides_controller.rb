module Api
  module V1
    class OutsidesController < ApplicationController

      before_filter :restrict_access

      respond_to :json

      def analyze
        @user = User.find_by_access_token(params[:access_token])
        respond_with @user
      end

      private

        def restrict_access
          api_key = User.find_by_access_token(params[:access_token])
          head :unauthorized unless api_key
        end

    end
  end
end