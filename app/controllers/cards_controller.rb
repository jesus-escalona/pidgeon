class CardsController < ApplicationController
	before_action :authenticate

	def index
		@cards = @logged_in_user.cards
	end

	def new
		@card = Card.new
	end

	def create
		@c = Card.new(card_params)
		@c.user = @logged_in_user
		if @c.save
		  redirect_to cards_path
		else
		  flash[:errors] = @c.errors.full_messages
		  redirect_to new_card_path
		end
	end

	def edit
		@card = Card.find(params[:id])
	end

	def update
		@card = Card.find(params[:id])
		if @card.update(card_params)
		  redirect_to cards_path
		else
		  flash[:errors] = @card.errors.full_messages
		  render :edit
		end
	end

	def destroy
		@card_id = params[:id]
		Card.destroy(@card_id)
		redirect_to cards_path
	end

	private

	def card_params
		params.require(:card).permit(:card_number, :security_code, :exp_date, :zip_code, :card_type)
	end
end
