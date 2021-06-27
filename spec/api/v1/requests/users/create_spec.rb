require 'rails_helper'

RSpec.describe "create user request spec" do
  describe "create user happy path" do
    it "when a post request is made with required data, a user is succesffuly created and relevant data is returned" do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = {   "email": "kyle@example.com", "password": "password", "password_confirmation": "password" }
      post '/api/v1/users', :params => params.to_json, :headers => headers
      response = parse(@response)
      expect(@response).to be_successful
      expect(response[:data].count).to eq(3)
      expect(response[:data].keys).to eq([:id, :type, :attributes])
      expect(response[:data][:id]).to_not be_nil
      expect(response[:data][:type]).to eq('user')
      expect(response[:data][:attributes].keys).to eq([:email, :api_key])
      expect(response[:data][:attributes][:email]).to eq("kyle@example.com")
      expect(response[:data][:attributes][:api_key].length).to eq(24)
      expect(response[:data][:attributes][:api_key]).to be_a(String)
    end
  end

  describe "create user sad path" do
    it "returns 422 if email is already in use" do
      User.destroy_all
      @user = User.create!(email: 'kyle@example.com', password: 'password')

      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = {   "email": "kyle@example.com", "password": "password", "password_confirmation": "password" }
      post '/api/v1/users', :params => params.to_json, :headers => headers

      expect(@response).to_not be_successful
      expect(@response.body).to eq("Email has already been taken")
      expect(@response.status).to eq(422)
    end

    it "returns 422 when given invalid email" do
      User.destroy_all
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = {   "email": "kyle", "password": "password", "password_confirmation": "password" }
      post '/api/v1/users', :params => params.to_json, :headers => headers
      expect(@response).to_not be_successful
      expect(@response.body).to eq("Email is invalid")
      expect(@response.status).to eq(422)
    end

    it "returns 422 if email is empty" do
      User.destroy_all
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = {   "email": "", "password": "password", "password_confirmation": "password" }
      post '/api/v1/users', :params => params.to_json, :headers => headers

      expect(@response).to_not be_successful
      expect(@response.body).to eq("Email can't be blank and Email is invalid")
      expect(@response.status).to eq(422)
    end

    it "returns 422 when given short password" do
      User.destroy_all
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = {   "email": "kyle@example.com", "password": "pass", "password_confirmation": "pass" }
      post '/api/v1/users', :params => params.to_json, :headers => headers

      expect(@response).to_not be_successful
      expect(@response.body).to eq("Password is too short (minimum is 6 characters)")
      expect(@response.status).to eq(422)
    end

    it "returns 422 when given no password" do
      User.destroy_all
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = {   "email": "kyle@example.com", "password": "", "password_confirmation": "" }
      post '/api/v1/users', :params => params.to_json, :headers => headers

      expect(@response).to_not be_successful
      expect(@response.body).to eq("Password can't be blank, Password can't be blank, Password is too short (minimum is 6 characters), and Password confirmation doesn't match Password")
      expect(@response.status).to eq(422)

    end

    it "returns 422 when password confirmation is incorrect" do
      User.destroy_all
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = {   "email": "kyle@example.com", "password": "password", "password_confirmation": "password_1" }
      post '/api/v1/users', :params => params.to_json, :headers => headers

      expect(@response).to_not be_successful
      expect(@response.body).to eq("Password confirmation doesn't match Password and Password confirmation doesn't match Password")
      expect(@response.status).to eq(422)
    end

    it "returns 422 when given no body at all" do
      User.destroy_all
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      post '/api/v1/users', :headers => headers

      expect(@response).to_not be_successful
      expect(@response.body).to eq("Password can't be blank, Password can't be blank, Password is too short (minimum is 6 characters), Email can't be blank, and Email is invalid")
      expect(@response.status).to eq(422)
    end
  end
end
