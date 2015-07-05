class CreatePlayer < ActiveRecord::Migration
  def up
    create_table :players do |t|
      t.string :name
      t.integer :position, :default => 0, :null => false
      t.timestamps null: false
    end
    add_index :players, [:position]
  end

  def down
    drop_table :players
  end
end