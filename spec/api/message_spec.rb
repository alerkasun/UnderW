require 'rails_helper'

RSpec.describe "Message Api", :type => :request do
  let(:accept_json) { { "Accept" => "application/json" } }
  let(:content_type_json) { { "Content-Type" => "application/json" } }
  let(:accept_and_content_type_json) { accept_json.merge(content_type_json) }

  describe "POST /api/v1/:device/messages" do
    let(:device) { create(:device) }

    context "with valid message" do
      before do
        post "/api/v1/#{device.key}/messages", { message: attributes_for(:message) }.to_json, accept_and_content_type_json
      end

      it "responds with success" do
        expect(response).to be_success
      end

      it "creates a new location" do
        expect(Message.count).to eq(1)
      end
    end

  end

end
