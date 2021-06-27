class CreateUserSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :user_searches do |t|
      t.references :user, foreign_key: true
      t.references :search, foreign_key: true

      t.timestamps
    end
  end
end
