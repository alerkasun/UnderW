require 'rails_helper'

RSpec.describe "UploadedFile Api", :type => :request do
  let(:accept_json) { { "Accept" => "application/json" } }
  let(:content_type_json) { { "Content-Type" => "application/json" } }
  let(:accept_and_content_type_json) { accept_json.merge(content_type_json) }

  describe "POST /api/v1/:device/uploaded_files" do
    let(:device) { create(:device) }
    context "with valid image file" do
      before do
        post "/api/v1/#{device.key}/uploaded_files", { uploaded_file: attributes_for(:uploaded_file) }, accept_and_content_type_json
      end

      it "responds with success" do
        expect(response).to be_success
      end

      it "creates a new uploaded file" do
        expect(UploadedFile.count).to eq(1)
      end

    end

  end


end