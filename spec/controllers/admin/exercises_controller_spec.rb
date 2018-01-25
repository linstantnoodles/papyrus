require 'rails_helper'

RSpec.describe Admin::ExercisesController, :type => :controller do
  context 'when session does not exist' do
    it 'redirects to posts' do
      get :index
      expect(response).to redirect_to(login_path)
    end
  end

  context 'when session exists' do
    before(:each) do
      user = User.create(name: 'admin', password: 'password')
      session[:user_id] = user.id
    end

    describe '#create' do
      it 'creates a new exercise' do
        post :create, params: {
          'title' => 'test title',
          'description' => 'test description',
          'test' => 'test code'
        }

        expect(Exercise.count).to eq(1)
      end

      it 'redirects to #index' do
        response = post :create, params: {
          'title' => 'test title',
          'description' => 'test description',
          'test' => 'test code'
        }

        expect(response).to redirect_to(admin_exercises_path)
      end

      context 'missing required fields' do
        it 'renders new' do
          response = post :create, params: {
            'title' => 'test title',
            'description' => 'test description'
          }

          expect(response).to render_template(:new)
        end
      end
    end
  end
end