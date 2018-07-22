module Admin
  class BaseController < ApplicationController
    layout 'admin'
    before_action :authenticate

    def current_user
      @current_user ||= User.find_by_id(session[:user_id])
    end

    def authenticate
      redirect_to login_path unless current_user
    end
  end
end