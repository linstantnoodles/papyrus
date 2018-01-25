module Admin
  class ExercisesController < ApplicationController
    layout 'admin'
    before_action :authenticate

    def index
      @exercises = Exercise.all
    end

    def new
      @exercise = Exercise.new
    end

    def create
      @exercise = Exercise.new(title: params[:title], description: params[:description], test: params[:test])
      if @exercise.save
        redirect_to admin_exercises_path
      else
        render :new
      end
    end

    def show
      @exercise = Exercise.find_by_id(params[:id])
    end

    def authenticate
      redirect_to login_path unless current_user
    end

    def current_user
      @current_user ||= User.find_by_id(session[:user_id])
    end
  end
end