require 'rails_helper'

RSpec.describe "PendingCommands Api", :type => :request do
  let(:accept_json) { { "Accept" => "application/json" } }
  let(:content_type_json) { { "Content-Type" => "application/json" } }
  let(:accept_and_content_type_json) { accept_json.merge(content_type_json) }

  describe "GET /api/v1/:device/pendingcommands" do
    let(:device) { create(:device) }

    context "when no pending commands" do
      before do
        get "/api/v1/#{device.key}/pendingcommands"
      end
      it "responds with success" do
        expect(response).to be_success
      end
      it "responses with empty pendingCommands array" do
        body = JSON.parse(response.body)
        expect(body).to have_key("pendingCommands")
        expect(body["pendingCommands"].size).to eq(0)
      end
    end

    context "when only completed commands" do
      before do
        create_list(:completedcommand, 3, device: device)
        get "/api/v1/#{device.key}/pendingcommands"
      end
      it "responds with success" do
        expect(response).to be_success
      end
      it "responses with empty pendingCommands array" do
        body = JSON.parse(response.body)
        expect(body).to have_key("pendingCommands")
        expect(body["pendingCommands"].size).to eq(0)
      end
    end

    context "when pending and completed commands" do
      before do
        create_list(:completedcommand, 3, device: device)
        create_list(:pendingcommand, 2, device: device)
        get "/api/v1/#{device.key}/pendingcommands"
      end
      it "responds with success" do
        expect(response).to be_success
      end
      it "responses with 2 pendingCommands" do
        body = JSON.parse(response.body)
        expect(body).to have_key("pendingCommands")
        expect(body["pendingCommands"].size).to eq(2)
      end
    end
  end

  describe "PUT /api/v1/:device/pendingcommands/:id" do
    let(:device) { create(:device) }
    let(:command) { create(:pendingcommand, device: device)}

    context "when parameters are ok" do
      before do
        put "/api/v1/#{device.key}/pendingcommands/#{command.id}", { pendingcommand: {completed_at: "2014-11-15 13:40:27 +0100"} }.to_json, accept_and_content_type_json
      end
      it "responds with success" do
        expect(response).to be_success
      end
      it "updates pendingcommand" do
        expect(Pendingcommand.find(command.id).completed_at).to eq("2014-11-15 13:40:27 +0100")
      end
    end

    context "with not permitted parameter" do
      before do
        put "/api/v1/#{device.key}/pendingcommands/#{command.id}", { pendingcommand: {command: "hack"} }.to_json, accept_and_content_type_json
      end

      it "responds with success" do
        expect(response).to be_success
      end
      it "not changes command" do
        expect(Pendingcommand.find(command.id).command).not_to eq("hack")
      end
    end

  end

end