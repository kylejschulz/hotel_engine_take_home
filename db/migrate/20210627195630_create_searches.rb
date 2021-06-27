class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.string :IATA_code
      t.integer :radius
      t.integer :room_quantity
      t.string :check_in_date
      t.string :check_out_date

      t.timestamps
    end
  end
end
