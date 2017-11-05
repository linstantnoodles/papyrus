require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
  describe '#destroy' do
    before do
      session[:user_id] = 1
    end
    it 'clears session' do
      allow(session).to receive(:clear)

      post :destroy

      expect(session).to have_received(:clear)
    end
    it 'redirects to root' do
      post :destroy

      expect(response).to redirect_to(root_path)
    end
  end
  describe '#create' do
    context 'when params are invalid' do
      it 'redirects to login' do
        user = User.create(name: 'admin', password: 'password')
        user.save
        post :create, params: {
          'name' => 'admin',
          'password' => 'bad-password'
        }
        expect(response).to redirect_to(login_path)
      end
    end
    context 'when params are valid' do
      it 'sets a session' do
        user = User.create(name: 'admin', password: 'password')
        user.save
        post :create, params: {
          'name' => 'admin',
          'password' => 'password'
        }
        expect(session[:user_id]).to eq(user.id)
      end
      it 'redirects to dashboard page' do
        user = User.create(name: 'admin', password: 'password')
        user.save
        post :create, params: {
          'name' => 'admin',
          'password' => 'password'
        }
        expect(response).to redirect_to(admin_posts_path)
      end
    end
  end
end