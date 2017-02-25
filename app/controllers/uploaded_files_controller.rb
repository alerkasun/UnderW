class UploadedFilesController <  ApplicationController
  before_action :authenticate_user!
  before_action :get_device

  def index
    @uploaded_files = @device.uploaded_files
  end

  def show
    @uploaded_file = @device.uploaded_files.find(params[:id])
    send_file @uploaded_file.file.path, x_sendfile: true, filename: @uploaded_file.original_filename
  end

  def destroy
    @uploaded_file = @device.uploaded_files.find(params[:id])
    @uploaded_file.destroy
    respond_to do |format|
      format.html { redirect_to device_uploaded_files_path(@device), notice: 'File deleted' }
      format.json { head :no_content }
    end
  end

  private

  def get_device
    if current_user.admin?
      @device = Device.find params[:device_id]
    else
      @device = current_user.devices.find params[:device_id]
    end
  end

end