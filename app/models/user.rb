class User < ApplicationRecord
	validates_uniqueness_of :username

	has_many :sent_transactions, class_name: "Transaction", foreign_key: "sender_id"
	has_many :received_transactions, class_name: "Transaction", foreign_key: "receiver_id"
	has_many :cards
	has_many :followers, class_name: "Relation", foreign_key: "follower_id"
	has_many :followeds, class_name: "Relation", foreign_key: "followed_id"

	has_secure_password

	def follows
		self.followers.map {|relation| relation.followed}
	end

	def fans
		self.followeds.map {|relation| relation.follower}
	end

	def receivers
		self.sent_transactions.map {|trans| trans.receiver}
	end

	def senders
		self.received_transactions.map {|trans| trans.sender}
	end

	def withdraw(amount)
		current_balance = self.balance
		self.update(balance: current_balance - amount)
	end

	def deposit(amount)
		current_balance = self.balance
		self.update(balance: current_balance + amount)
	end

	def self.search(search)
	  if search
	  	w = search.downcase
	    User.where("LOWER(username) LIKE ? OR LOWER(name) LIKE ?", "%#{w}%", "%#{w}%")
	  else
	    User.all
	  end
	end
end