class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.references :user, foreign_key: true
      t.string :card_number
      t.integer :security_code
      t.string :card_type
      t.integer :zip_code
      t.datetime :exp_date

      t.timestamps
    end
  end
end
