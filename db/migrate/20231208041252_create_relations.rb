class CreateRelations < ActiveRecord::Migration[7.1]
  def change
    create_table :relations do |t|
      t.references :follower, index: true, foreign_key: {to_table: :users}
      t.references :followed, index: true, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
