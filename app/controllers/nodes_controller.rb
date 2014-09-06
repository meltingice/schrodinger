class NodesController < ApplicationController
  def contents_for_path
    render partial: 'nodes/contents_for_path'
  end
end
