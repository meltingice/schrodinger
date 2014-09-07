class NodesController < ApplicationController
  def stats
    render json: current_node
  end

  def sidebar
    render partial: 'stats/sidebar'
  end

  def file_list
    render partial: 'stats/file_list'
  end
end
