class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_uid(auth["uid"])
    if user
      session[:user_id] = user
    else
      user = User.new(uid: auth["uid"], name: auth["info"]["name"])
      user.save
      session[:user_id] = user
    end
    redirect_to request.env['omniauth.origin'] || root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to :back
  end

end
