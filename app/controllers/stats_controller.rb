class StatsController < ApplicationController
  before_action :require_user

  def index
    redirect_to wait_path unless current_user.account_ready?
  end

  def wait
  end
end
