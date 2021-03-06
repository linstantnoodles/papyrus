require 'tempfile'
module Admin
  class SubmissionsController < BaseController
    def index
      @submissions = Submission.where(exercise_id: params[:exercise_id]).order('created_at DESC')
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
        render :json => {:errors => @submission.errors.full_messages }, :status => 400
      end
    end
  end
end