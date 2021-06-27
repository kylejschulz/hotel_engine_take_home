require 'rails_helper'

RSpec.describe UserSearch, type: :model do
  describe "add some examples to (or delete)" do
    it { should belong_to(:user) }
    it { should belong_to(:search) }
  end
end
