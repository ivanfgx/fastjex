class DashboardController < ApplicationController
  def index
    @creditors = current_user.payment_schedules
  end
end