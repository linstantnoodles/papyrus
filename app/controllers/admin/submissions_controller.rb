module Admin
  class SubmissionsController < ApplicationController
    layout 'admin'
    before_action :authenticate

    def index
      @submissions = Submission.all
    end

    def new
      @submission = Submission.new(exercise_id: params[:exercise_id])
    end

    def create
      @submission = Submission.new(content: params[:content], exercise_id: params[:exercise_id])
      if @submission.save
        redirect_to admin_exercises_path
      else
        render :new
      end
    end

    def authenticate
      redirect_to login_path unless current_user
    end

    def current_user
      @current_user ||= User.find_by_id(session[:user_id])
    end
  end
end