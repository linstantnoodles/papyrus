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
end
