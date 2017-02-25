class PendingcommandsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_device

  def index
    @commands = @device.pendingcommands
    render json: @commands
  end

  def create
    @command = @device.pendingcommands.build(pendingcommand_params)
    if @command.save
      head :no_content
      SendGcmMessageJob.perform_later @device.id
    else
      render json: @command.errors, status: :unprocessable_entity
    end
  end

  private

  def get_device
    @device = current_user.devices.find params[:device_id]
  end

  def pendingcommand_params
    params.require(:pendingcommand).permit(:command)
  end

end
