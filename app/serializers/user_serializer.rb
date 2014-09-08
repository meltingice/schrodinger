class UserSerializer < BaseSerializer
  attributes :dropbox_id, :name, :account_ready, :last_checked_at, :created_at, :updated_at, :quota, :total_size

  def last_checked_at
    object.last_checked_at.to_i
  end

  def quota
    object.account['quota']
  end

  def total_size
    root = object.root_node
    return 0 if root.nil?
    root.deep_size
  end
end
