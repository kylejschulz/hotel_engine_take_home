require 'rails_helper'

RSpec.describe User, model: :type do
  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should have_secure_password }

  end

  describe "associations" do
    it { should have_many(:user_searches) }
    it { should have_many(:searches).through(:user_searches) }
  end

  describe "instance methods" do
    it "#assign_api_key" do
      user = User.new(email: 'KYLE@example.com', password: 'password')
      user.assign_api_key

      expect(user.api_key.length).to eq(24)
      expect(user.api_key.class).to eq(String)

    end

    it "#downcase_email" do
      user = User.new(email: 'KYLE@example.com', password: 'password')
      user.downcase_email

      expect(user.email).to eq("kyle@example.com")
    end
  end
end
