class UsersController < ApplicationController

	def index
		authenticate
		@users = User.search(params[:search])
		if @users.empty?
			@errors = ["Whoops!, no user matches your search"]
		end
	end

	def new
    	@user = User.new
  	end

	def create
		@user = User.new(user_params)
		if @user.save
		  log_in!(@user)
		  redirect_to users_dashboard_path
		else
		  flash[:errors] = @user.errors.full_messages
		  redirect_to new_user_path
		end
	end

	def dashboard
		authenticate
		@transactions = Transaction.all.sort_by {|t| t.created_at.to_i * -1}
	end

	def profile
		authenticate
	end

	def update
		@name = user_edit_params[:name]
		@email = user_edit_params[:email]
		uploaded_io = user_edit_params[:image]
		if uploaded_io
			ext = File.extname(uploaded_io.original_filename)
			filename = "#{@logged_in_user.username}#{ext}"
			File.open(Rails.root.join('app', 'assets', 'images', filename), 'wb') do |file|
		  		file.write(uploaded_io.read)
			end
			@logged_in_user.update(image: filename)
		end

		if @logged_in_user.update(name: @name, email: @email, image: filename)
		  	redirect_to users_profile_path
		else
		  	flash[:errors] = @c.errors.full_messages
		  	render :edit
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :username, :password, :password_confirmation)
	end

	def user_edit_params
		params.require(:user).permit(:name, :email, :image)
	end


end
