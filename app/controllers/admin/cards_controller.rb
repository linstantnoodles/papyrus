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
    # gather up cards
    # redirect to different route with specific card view
  end

  def show_front
  end

  def show_back
  end

  def review
    # re
  end
end
