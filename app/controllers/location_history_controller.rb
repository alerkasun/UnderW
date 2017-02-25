class LocationHistoryController < ApplicationController
  before_action :authenticate_user!

  def index
    @devices = current_user.devices
  end

  def show
    puts params.inspect
    if current_user.admin?
      @device = Device.find params[:id]
    else
      @device = current_user.devices.find params[:id]
    end
    @locations = @device.locations
    unless params[:filter].nil?
      @locations = @locations.filter params[:filter].slice("date_from", "date_to", "limit", "sort", "accuracy_better_than")
    end
    respond_to do |format|
      format.json {render json: @locations}
    end
  end

end
