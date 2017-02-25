class Api::V1::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_device

  protected

  def set_device
    @device = Device.find_by_key params[:device_key]
  end
end