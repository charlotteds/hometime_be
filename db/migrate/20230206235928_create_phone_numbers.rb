class CreatePhoneNumbers < ActiveRecord::Migration[6.1]
  def change
    create_table :phone_numbers do |t|
      t.string :value
      t.references :guest, null: false, foreign_key: true

      t.timestamps
    end
  end
end
