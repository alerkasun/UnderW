class Api::V1::UploadedFilesController < Api::V1::BaseController

  def create
    @uploaded_file = @device.uploaded_files.create uf_params
    if @uploaded_file.errors.empty?
      @device.messages.create(text: "New file uploaded: #{view_context.link_to @uploaded_file.original_filename, device_uploaded_file_path(@device, @uploaded_file)}")
      head :ok
    else
      render json: @uploaded_file.errors, status: :unprocessable_entity
    end
  end

  private

  def uf_params
    params.require(:uploaded_file).permit(:file)
  end
end