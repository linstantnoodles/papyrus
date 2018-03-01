require 'rails_helper'

RSpec.describe Admin::CardsController, type: :controller do
    describe '#create' do
      it 'creates a new card' do
        post :create, params: {
          'front' => 'test front',
          'back' => 'test back'
        }

        expect(Card.count).to eq(1)
      end

      it 'redirects to #index' do
        response = post :create, params: {
          'front' => 'test front',
          'back' => 'test back'
        }

        expect(response).to redirect_to(admin_cards_path)
      end

      context 'missing required fields' do
        it 'renders new' do
          response = post :create, params: {
            'front' => '',
            'content' => 'test content'
          }

          expect(response).to render_template(:new)
        end
      end
    end
end
