class UserSerializer < BaseSerializer
  attributes :dropbox_id, :name, :account_ready, :last_checked_at, :created_at, :updated_at

  def last_checked_at
    object.last_checked_at.to_i
  end
end
