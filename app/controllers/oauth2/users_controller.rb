module Oauth2
  class UsersController < ApplicationController
    before_filter :ensure_token!
    before_filter :find_user

    def show
      render :json => @user.attributes.only(*%w[name email uuid])
    end

    protected

    def find_user
      @user = find_user_by_uuid(@access_token.user_id) or render(:nothing => true, :status => :bad_request)
    end

    def ensure_token!
      @access_token = Oauth2Token.find!(:token => params[:access_token])
    end
  end
end
