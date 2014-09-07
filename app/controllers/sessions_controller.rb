class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_auth_hash(auth_hash)
    session[:dropbox_id] = user.id

    DropboxWorker.update_for(user)

    redirect_to user.account_ready? ? stats_path : wait_path
  end

  def destroy
    session.destroy
    redirect_to '/'
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
