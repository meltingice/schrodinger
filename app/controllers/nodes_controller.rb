class NodesController < ApplicationController
  def stats
    render json: current_node
  end

  def contents_for_path
    render partial: 'nodes/contents_for_path'
  end
end
