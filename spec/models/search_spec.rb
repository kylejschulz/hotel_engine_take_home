require 'rails_helper'

RSpec.describe Search, type: :model do
  describe "validations" do
    it { should validate_presence_of(:IATA_code) }
  end

  describe "relationships" do
    it { should have_many(:user_searches) }
    it { should have_many(:users).through(:user_searches) }
  end
end
