class Admin::CardsController < ApplicationController
  layout 'admin'

  before_action :authenticate

  def index
    @cards = Card.all
    @tags = Tag.all.order('name ASC')
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
        back: params[:back],
        tags: tags
      )
        redirect_to admin_cards_path
      else
        render :edit
      end
  end

  def create
    @card = Card.new(front: params[:front], back: params[:back])
    if @card.save
      @card.update(tags: tags)
      redirect_to admin_cards_path
    else
      render :new
    end
  end

  def tags
    return [] unless !params[:tags].blank?
    params[:tags].split(',').map {
      |name| Tag.find_or_create_by(name: name.strip)
    }
  end

  def review_all
    cards = Card.all.select(&:due_for_review?)
    if params[:tag]
      cards = cards.select do |card|
        card.tags.map(&:name).include?(params[:tag])
      end
    end
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
