require 'rails_helper'

RSpec.describe Admin::CardsController, type: :controller do
  context 'when session exists' do
    before(:each) do
      user = User.create(name: 'admin', password: 'password')
      session[:user_id] = user.id
    end

    describe '#create' do
      it 'creates a new card' do
        post :create, params: {
          'front' => 'test front',
          'back' => 'test back'
        }

        expect(Card.count).to eq(1)
      end

      context 'when tag exists' do
        it 'creates new card with tags' do
          post :create, params: {
            'front' => 'test front',
            'back' => 'test back',
            'tags' => 'tag1, tag2'
          }

          expect(Card.first.tags.size).to eq(2)
          expect(Card.first.tags.first.name).to eq('tag1')
          expect(Card.first.tags.second.name).to eq('tag2')
        end
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

    describe '#update' do
      context 'when params valid' do
        it 'redirects to index' do
          my_card = Card.new(front: 'test-front', back: 'test-back')
          my_card.save
          post :update, params: {
            'id' => my_card.id,
            'front' => 'new front',
            'back' => 'new back'
          }

          expect(my_card.reload.front).to eq('new front')
          expect(my_card.reload.back).to eq('new back')
          expect(response).to redirect_to(admin_cards_path)
        end
      end

      context 'when params invalid' do
        it 'renders edit' do
          my_card = Card.new(front: 'test-front', back: 'test-back')
          my_card.save
          post :update, params: {
            'id' => my_card.id,
            'front' => '',
            'back' => ''
          }

          expect(response).to render_template(:edit)
        end
      end
    end

    describe '#review' do
      context 'when card is to be repeated' do
        it 'pushes the card id to the end of the queue' do
          card = Card.create(front: 'front', back: 'back')
          session[:review_queue_card_ids] = [card.id, 2]
          post :review, params: {
            id: card.id,
            score: 1
          }
          expect(session[:review_queue_card_ids]).to eq([2, card.id])
        end
      end

      context 'when card is not going to be repeated' do
        it 'removes the card from the queue' do
          card = Card.create(front: 'front', back: 'back')
          session[:review_queue_card_ids] = [card.id, 2]
          post :review, params: {
            id: card.id,
            score: 5
          }
          expect(session[:review_queue_card_ids]).to eq([2])
        end
      end

      context 'when queue is not empty' do
        it 'redirects to the next card in the queue' do
          card = Card.create(front: 'front', back: 'back')
          session[:review_queue_card_ids] = [card.id, 2]
          response = post :review, params: {
            id: card.id,
            score: 5
          }

          expect(response).to redirect_to(show_front_admin_card_path(id: 2))
        end
      end

      context 'when queue is empty' do
        it 'redirects to home page' do
          card = Card.create(front: 'front', back: 'back')
          session[:review_queue_card_ids] = [card.id]
          response = post :review, params: {
            id: card.id,
            score: 5
          }

          expect(response).to redirect_to(admin_cards_path)
        end
      end
    end

    describe '#review_all' do
      context 'when no cards are due for review' do
        it 'redirects to home page' do
          response = get :review_all

          expect(response).to redirect_to(admin_cards_path)
        end
      end

      context 'when cards are due for review' do
        before do
          @card_one = Card.create(front: 'front', back: 'back', next_due_date: 1.day.ago)
          @card_two = Card.create(front: 'front', back: 'back', next_due_date: 1.day.ago)
          @card_three = Card.create(front: 'front', back: 'back', next_due_date: 1.day.ago)
        end

        it 'sets the session with card ids ordered by creation time' do
          response = get :review_all

          expect(session[:review_queue_card_ids]).to eq([@card_one.id, @card_two.id, @card_three.id])
        end

        it 'redirects to show the front of the first card in the list' do
          response = get :review_all

          expect(response).to redirect_to(show_front_admin_card_path(id: @card_one.id))
        end
      end

      context 'when no cards are tagged with tag' do
        it 'redirects to home page' do
          response = get :review_all, params: {tag: 'wow'}
          expect(response).to redirect_to(admin_cards_path)
        end
      end

      context 'when tagged cards are due for review' do
        before do
          @tag = Tag.create(name: 'peaches')
          @tagged_card_one = Card.create(front: 'front', back: 'back', next_due_date: 1.day.ago)
          @tagged_card_one.update(tags: [@tag])
          @untagged_card_two = Card.create(front: 'front', back: 'back', next_due_date: 1.day.ago)
        end

        it 'sets the session with tagged card ids' do
          response = get :review_all, params: {tag: @tag.name}

          expect(session[:review_queue_card_ids]).to eq([@tagged_card_one.id])
        end

        it 'redirects to show the front of the tagged card in the list' do
          response = get :review_all, params: {tag: @tag.name}

          expect(response).to redirect_to(show_front_admin_card_path(id: @tagged_card_one.id))
        end
      end
    end
  end
end
