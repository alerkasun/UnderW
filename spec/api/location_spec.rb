require 'rails_helper'

RSpec.describe "Location Api", :type => :request do
  let(:accept_json) { { "Accept" => "application/json" } }
  let(:content_type_json) { { "Content-Type" => "application/json" } }
  let(:accept_and_content_type_json) { accept_json.merge(content_type_json) }

  describe "POST /api/v1/:device/locations" do
    let(:device) { create(:device) }

    context "with valid single location" do
      before do
        post "/api/v1/#{device.key}/locations", { location: attributes_for(:location) }.to_json, accept_and_content_type_json
      end

      it "responds with success" do
        expect(response).to be_success
      end

      it "creates a new location" do
        expect(Location.count).to eq(1)
      end
    end

    context "with valid multiple locations" do
      before do
        post "/api/v1/#{device.key}/locations", { location: [ attributes_for(:location), attributes_for(:location, latitude: 47.12345) , attributes_for(:location, latitude: 47.12345) ] }.to_json, accept_and_content_type_json
      end

      it "responds with success" do
        expect(response).to be_success
      end

      it "creates a multiple new location" do
        expect(Location.count).to eq(3)
      end
    end

    context "with multiple locations where one is invalid" do
      before do
        post "/api/v1/#{device.key}/locations", { location: [ attributes_for(:location), attributes_for(:location).except(:latitude) , attributes_for(:location, latitude: 47.12345) ] }.to_json, accept_and_content_type_json
      end

      it "responds with error" do
        expect(response).to have_http_status(422)
      end

      it "creates a multiple new location" do
        expect(Location.count).to eq(2)
      end

      it "responds with json of errors" do
        body = JSON.parse(response.body)
        expect(body).to have_key("errors")
        expect(body["errors"].size).to eq(1)
      end

    end

    context "with missing required parameters" do
      before do
        params = { location: attributes_for(:location) }
        params[:location].delete :time
        params[:location].delete :latitude
        params[:location].delete :longitude
        post "/api/v1/#{device.key}/locations", params.to_json, accept_and_content_type_json
      end

      it "responds with error" do
        expect(response).to have_http_status(422)
      end

      it "does not reates a new location" do
        expect(Location.count).to eq(0)
      end

      it "responds with json of errors" do
        body = JSON.parse(response.body)
        expect(body).to have_key("errors")
        expect(body["errors"]).to include("Latitude can't be blank")
        expect(body["errors"]).to include("Longitude can't be blank")
        expect(body["errors"]).to include("Time can't be blank")
      end
    end


  end

end
