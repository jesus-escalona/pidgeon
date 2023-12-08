class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references :sender, index: true, foreign_key: {to_table: :users}
      t.references :receiver, index: true, foreign_key: {to_table: :users}
      t.decimal :amount, precision: 16, scale: 2
      t.string :currency, default: "USD"
      t.string :message

      t.timestamps
    end
  end
end
