class Relation < ApplicationRecord
	validates :follower, uniqueness: { scope: :followed }
	validate :cant_follow_yourself

	belongs_to :follower, class_name: "User"
	belongs_to :followed, class_name: "User"

	private

	  	def cant_follow_yourself
	    	if follower == followed
	    		errors.add(:what, "You cannot follow yourself!")
	    	end
	  	end

end
