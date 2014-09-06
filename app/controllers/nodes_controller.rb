class NodesController < ApplicationController
  def update
    service = DropboxTree.service_for(current_user)
    service.fetch!
  end
end
