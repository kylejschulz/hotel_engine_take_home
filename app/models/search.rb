class Search < ApplicationRecord
  validates_presence_of :IATA_code
  has_many :user_searches
  has_many :users, through: :user_searches
end
