class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_uid(auth["uid"])
    if user
      session[:user_id] = user.id
    else
      user = User.new(uid: auth["uid"], name: auth["info"]["name"])
      user.save
      session[:user_id] = user.id
    end
    redirect_to request.env['omniauth.origin'] || root_path
  end

  def create_developer
    user = User.find_by_uid('developer')
    if user
      session[:user_id] = user.id
    else
      user = User.new(uid: 'developer', name: '開発者')
      user.save
      session[:user_id] = user.id
    end
    redirect_to :back
  end

  def destroy
    session[:user_id] = nil
    redirect_to :back
  end

end
