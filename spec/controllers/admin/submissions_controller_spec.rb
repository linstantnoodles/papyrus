require 'rails_helper'

RSpec.describe Admin::SubmissionsController, :type => :controller do
  context 'when session does not exist' do
    it 'redirects to posts' do
      exercise = Exercise.create(title: 'test-title', description: 'test-description', test: 'test')
      get :index, params: {
        'exercise_id' => exercise.id
      }
      expect(response).to redirect_to(login_path)
    end
  end

  context 'when session exists' do
    before(:each) do
      user = User.create(name: 'admin', password: 'password')
      session[:user_id] = user.id
    end

    describe '#create' do
      before do
        @exercise = Exercise.create(title: 'test-title', description: 'test-description', test: 'test')
      end

      it 'creates a new submission' do
        post :create, params: {
          'content' => 'code',
          'exercise_id' => @exercise.id
        }

        expect(@exercise.submissions.count).to eq(1)
      end

      # it 'redirects to #index' do
      #   response = post :create, params: {
      #     'title' => 'test title',
      #     'description' => 'test description',
      #     'test' => 'test code'
      #   }

      #   expect(response).to redirect_to(admin_exercises_path)
      # end

      # context 'missing required fields' do
      #   it 'renders new' do
      #     response = post :create, params: {
      #       'title' => 'test title',
      #       'description' => 'test description'
      #     }

      #     expect(response).to render_template(:new)
      #   end
      # end
    end
  end
end