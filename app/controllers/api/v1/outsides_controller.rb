module Api
  module V1
    class OutsidesController < ApplicationController

      before_filter :allow_cross_domain_access, :restrict_access

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

        def allow_cross_domain_access
          response.headers["Access-Control-Allow-Origin"] = "https://www2.adst.keio.ac.jp/rcs/servlet/jp.ac.keio.rcs.servlet.view.TopMenuServlet"
          response.headers["Access-Control-Allow-Headers"] = "Content-Type"
          response.headers["Access-Control-Allow-Methods"] = "PUT,DELETE,POST,GET,OPTIONS"
        end

    end
  end
end