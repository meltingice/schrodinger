module DropboxTree
  extend self

  def service_for(user)
    root = user.node_root

    if root.nil?
      DropboxTree::CreateService.new(user)
    else
      DropboxTree::UpdateService.new(user, root)
    end
  end
end
