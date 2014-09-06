class User < ActiveRecord::Base
  self.primary_key = :dropbox_id

  serialize :account, Hash

  def self.find_or_create_from_auth_hash(auth)
    user = User.where(dropbox_id: auth['uid']).first
    
    if user.nil?
      user = User.new
      user.dropbox_id = auth['uid']
    end

    user.access_token = auth['credentials']['token']
    user.account = auth['info'].to_h
    user.account['quota'] = auth['extra']['raw_info']['quota_info'].to_h
    user.save!
    user
  end

  def name
    account['name']
  end

  def node_root
    Node.roots.where(dropbox_id: id).first
  end
end
