require 'rouge'

module Admin
  class ExercisesController < BaseController
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

    def edit
      @exercise = Exercise.find_by_id!(params[:id])
    end

    def update
      @exercise = Exercise.find_by_id!(params[:id])
      if @exercise.update_attributes(title: params[:title], description: params[:description], test: params[:test])
        redirect_to admin_exercises_path
      else
        render :edit
      end
    end

    def practice
      @exercise = Exercise.find_by_id(params[:id])
      theme = Rouge::Themes::Github
      formatter = Rouge::Formatters::HTMLInline.new(theme)
      lexer = Rouge::Lexers::Ruby.new
      @stuff = formatter.format(lexer.lex(@exercise.test)).html_safe
    end
  end
end