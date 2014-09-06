class DropboxWorker
  include Sidekiq::Worker
  sidekiq_options queue: Rails.env.to_s

  def self.update_for(user)
    perform_async user.id
  end

  def perform(user_id)
    user = User.find(user_id)
    DropboxTreeService.new(user).update!
  end
end
