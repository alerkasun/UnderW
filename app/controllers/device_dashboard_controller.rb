class DeviceDashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.devices.size > 0
      redirect_to action: :show, id: current_user.devices.first.id
    end
  end

  def show
    @devices = current_user.devices
    @device = @devices.find(params[:id])
    if params[:last_message]
      @messages = @device.messages.where("created_at > ?", Time.parse(params[:last_message]) + 0.001.second)
    else
      @messages = @device.messages.last(5)
    end
    respond_to do |format|
      format.html
      format.json
    end
  end
end
