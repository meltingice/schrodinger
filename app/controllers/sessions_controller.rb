class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_auth_hash(auth_hash)
    session[:dropbox_id] = user.id

    # We always update the account on login. If this is a new user, it will
    # build their tree for the first time. If it's an existing user, it will
    # check for any changes since the last sync.
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
