class DropboxController < ApplicationController
  def verify
    respond_with text: params[:challenge]
  end

  def webhook
    params[:delta][:users].each do |user_id|
      DropboxWorker.perform_async(user_id)
    end
  end
end