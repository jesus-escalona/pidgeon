class RelationsController < ApplicationController
	before_action :authenticate

	def index
		@followers = @logged_in_user.fans
		@followings = @logged_in_user.follows
	end

	def create
    	@user = User.find(relation_params[:format])
    	@relation = Relation.new(follower: @logged_in_user, followed: @user)
		    if @relation.save
		      redirect_back fallback_location: root_path
		    else
		      flash[:errors] = @relation.errors.full_messages
		      redirect_back fallback_location: root_path
		    end
  	end

  	def destroy
  		@user = User.find(relation_id_params[:id])
		@r = Relation.find_by(follower: @logged_in_user, followed: @user)
		@r.destroy
		redirect_back fallback_location: root_path
	end

  	private

  	def relation_params
		params.permit(:format)
  	end

  	def relation_id_params
		params.permit(:id)
  	end
end
