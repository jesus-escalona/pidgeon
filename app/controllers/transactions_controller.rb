class TransactionsController < ApplicationController
before_action :authenticate
	def index
		 @my_sent = @logged_in_user.sent_transactions.sort_by {|t| t.created_at.to_i * -1}
		 @my_received = @logged_in_user.received_transactions.sort_by {|t| t.created_at.to_i * -1}
	end

	def new
		@transaction = Transaction.new
		@all_users = User.all
	end

	def create
		@receiver = User.find(transaction_params[:receiver])
		@amount = transaction_params[:amount].to_d
		@message = transaction_params[:message]
		@t = Transaction.new(sender: @logged_in_user, receiver: @receiver, amount: @amount, message: @message)
		if @t.valid?
			Transaction.transaction do
				@t.save
				@logged_in_user.withdraw(@amount)
				@receiver.deposit(@amount)
			end
			redirect_to transactions_path
		else
			flash[:errors] = @t.errors.full_messages
		  	redirect_to new_transaction_path
		end
	end

	private

	def transaction_params
		params.require(:transaction).permit(:receiver, :amount, :message)
	end
end
