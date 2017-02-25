class Api::V1::LocationsController < Api::V1::BaseController

  def create
    @locations = @device.locations.create location_params
    @errors = @locations.collect {|location| location.errors.full_messages }.flatten

    if @errors.empty?
      head :ok
    else
      render json: {errors: @errors}, status: :unprocessable_entity
    end
  end

  private

  def location_params
    unless params[:location].is_a? Array
      params[:location] = [ params[:location] ]
    end
    params.permit(location: [:latitude, :longitude, :altitude, :accuracy, :provider, :time]).require(:location)
  end

end
