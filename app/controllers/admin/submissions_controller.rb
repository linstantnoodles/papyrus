require 'tempfile'

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
        test_code = Exercise.find_by_id(params[:exercise_id]).test
        submission_content = @submission.content
        file = Tempfile.new(['spec_file', 'rb'])
        output = ''
        begin
          file.write("#{submission_content}\n#{test_code}")
          file.rewind
          output = `rspec #{file.path}`
        ensure
          file.close
          file.unlink
        end
        render :json => {:result => "#{output}"}
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