class Admin::CardsController < ApplicationController
  layout 'admin'

  before_action :authenticate

  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end

  def edit
    @card = Card.find_by_id!(params[:id])
  end

  def update
    @card = Card.find_by_id!(params[:id])
      if @card.update_attributes(
        front: params[:front],
        back: params[:back]
      )
        redirect_to admin_cards_path
      else
        render :edit
      end
  end

  def create
    @card = Card.new(front: params[:front], back: params[:back])
    if @card.save
      redirect_to admin_cards_path
    else
      render :new
    end
  end

  def review_all
    cards = Card.all.select(&:due_for_review?)
    if cards.present?
      review_queue_card_ids = cards.collect(&:id)
      session[:review_queue_card_ids] = review_queue_card_ids
      redirect_to show_front_admin_card_path(id: review_queue_card_ids.first)
    else
      redirect_to admin_cards_path
    end
  end

  def show_front
    @card = Card.find(params[:id])
  end

  def show_back
    @card = CardDecorator.new(card: Card.find(params[:id]))
  end

  def review
    card_id = params[:id].to_i
    score = params[:score].to_i
    card = Card.find(card_id)
    card = card.review_with_performance_score(score)
    card.save

    queue = session[:review_queue_card_ids]
    queue.delete(card_id)
    if card.repeat?(score)
      queue << card_id
    end
    session[:review_queue_card_ids] = queue

    if queue.present?
      redirect_to show_front_admin_card_path(id: queue.first)
    else
      redirect_to admin_cards_path
    end
  end

  def destroy
    @card = Card.find_by_id!(params[:id])
    @card.destroy
    redirect_to admin_cards_path
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def authenticate
    redirect_to login_path unless current_user
  end
end
