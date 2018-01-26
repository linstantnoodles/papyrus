require 'rails_helper'

RSpec.describe Admin::SubmissionsController, :type => :controller do
  context 'when session does not exist' do
    it 'redirects to posts' do
      test_code = %q{
        it 'should be true' do
          expect(x).to be(true)
        end
      }
      exercise = Exercise.create(title: 'test-title', description: 'test-description', test: test_code)
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
        test_code = %q{
          describe 'hi' do
            it 'should be true' do
              expect(x).to be(true)
            end
          end
        }
        @exercise = Exercise.create(title: 'test-title', description: 'test-description', test: test_code)
      end

      it 'creates a new submission' do
        content = %q{
          x = true
        }
        post :create, params: {
          'content' => content,
          'exercise_id' => @exercise.id
        }

        expect(@exercise.submissions.count).to eq(1)
      end

      it 'returns result of submission' do
        content = %q{
          x = true
        }
        response = post :create, params: {
          'content' => content,
          'exercise_id' => @exercise.id
        }

        expect(response.body).to include('1 example, 0 failures')
      end

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