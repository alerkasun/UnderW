class Api::V1::DevicesController < Api::V1::BaseController

  def show
  end

  def update
    if @device.update(allowed_params)
      head :ok
    else
      render json: @device.errors, status: :unprocessable_entity
    end
  end

  private

  def allowed_params
    params.require(:device).permit(:gcm_regid)
  end

end
