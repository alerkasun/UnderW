class Api::V1::PendingcommandsController < Api::V1::BaseController
  def index
    @pendingcommands = @device.pendingcommands.unfinished
    render json: {pendingCommands: @pendingcommands}
  end

  def update
    @pendingcommand = @device.pendingcommands.find(params[:id])
    if @pendingcommand.update(pendingcommand_params)
      @device.messages.create(text: "Command finished: " + @pendingcommand.command)
      head :ok
    else
      render json: @pendingcommand.errors, status: :unprocessable_entity
    end
  end

  private

  def pendingcommand_params
    params.require(:pendingcommand).permit(:completed_at)
  end

end
