class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :name
      t.string :email
      t.string :image, default: "default.jpg"
      t.decimal :balance, precision: 16, scale: 2, default: 500
      t.integer :country_id
      t.integer :phone_number

      t.timestamps
    end

  end
end
