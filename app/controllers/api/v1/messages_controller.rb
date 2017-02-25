class Api::V1::MessagesController < Api::V1::BaseController

  def create
    @message = @device.messages.create message_params
    if @message.errors.empty?
      head :ok
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  private

  def message_params
    p = params.require(:message).permit(:text)
    p[:text] = ERB::Util.html_escape p[:text]
    p
  end
end