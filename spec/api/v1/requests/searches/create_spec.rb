require 'rails_helper'

RSpec.describe "Search request" do
  before :each do
    @user = User.create!(email: 'kyle@example.com', password: 'password')
  end
  describe "happy path" do
    xit "returns all the appropriate data", :vcr do
      @user_2 = User.create!(email: 'kyle_s@example.com', password: 'password')

      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = { 'IATA_code': 'JFK', 'radius': '6', 'api_key': @user_2.api_key }
      post '/api/v1/search', :params => params.to_json, :headers => headers

      response = parse(@response)
      expect(@response).to be_successful
      expect(response[:data].count).to eq(3)
      expect(response[:data].keys).to eq([:id, :type, :attributes])
      expect(response[:data][:id]).to be_nil
      expect(response[:data][:type]).to eq('search')
      expect(response[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
      expect(response[:data][:attributes][:start_city]).to eq('Denver,CO')
      expect(response[:data][:attributes][:end_city]).to eq('Boulder,CO')
      expect(response[:data][:attributes][:travel_time]).to eq('41 minutes')
      expect(response[:data][:attributes][:weather_at_eta].keys).to eq([:temperature, :conditions])
      expect(response[:data][:attributes][:weather_at_eta][:temperature]).to eq(45.73)
      expect(response[:data][:attributes][:weather_at_eta][:conditions]).to eq("overcast clouds")
    end
  end
end
