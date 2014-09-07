class NodesController < ApplicationController
  before_action :require_user

  def stats
    render json: current_node
  end

  def breadcrumbs
    render partial: 'stats/breadcrumbs'
  end

  def sidebar
    render partial: 'stats/sidebar'
  end

  def file_list
    render partial: 'stats/file_list'
  end
end
