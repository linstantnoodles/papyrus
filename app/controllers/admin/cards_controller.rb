class Admin::CardsController < ApplicationController
  layout 'admin'
  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
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
    @card = Card.find(params[:id])
  end

  def review
    queue = session[:review_queue_card_ids]
    queue.delete(params[:id].to_i)
    score = params[:score].to_i
    card = Card.find(params[:id])
    card = card.review_with_performance_score(score)
    card.save
    if card.repeat?(score)
      queue << params[:id].to_i
    end
    session[:review_queue_card_ids] = queue
    if queue.present?
      redirect_to show_front_admin_card_path(id: queue.first)
    else
      redirect_to admin_cards_path
    end
  end
end
