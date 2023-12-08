class ApplicationController < ActionController::Base

  before_action :setup_global_errors, :setup_user_stuff

  private

  def log_in!(user)
    session[:user_id] = user.id
  end

  def setup_global_errors
    @errors = flash[:errors]
  end

  def logged_in?
    !!session[:user_id]
  end

  def setup_user_stuff
    if session["user_id"]
      @logged_in_user = User.find(session["user_id"])
      sql = "select count(*) from (select followed_id from relations f where f.follower_id = #{session["user_id"].to_i} UNION select follower_id from relations f where f.followed_id = #{session["user_id"].to_i})as a"
      @friendships = ActiveRecord::Base.connection.execute(sql).getvalue(0,0)
    end
  end

  def authenticate
    redirect_to new_session_path unless logged_in?
  end
end
