class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.string :code, index: { unique: true }
      t.date :start_date
      t.date :end_date
      t.integer :nights
      t.integer :guests_count
      t.integer :adults_count
      t.integer :children_count
      t.integer :infants_count
      t.string :status
      t.string :currency
      t.float :payout_price
      t.float :security_price
      t.float :total_price
      t.references :guest, null: false, foreign_key: true

      t.timestamps
    end
  end
end
