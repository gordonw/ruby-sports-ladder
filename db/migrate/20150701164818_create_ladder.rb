class CreateLadder < ActiveRecord::Migration
  def up
    create_table :ladders do |t|
      t.string :slug
      t.string :name
      t.string :description
      t.timestamps null: false
    end
  end

  def down
    drop_table :ladders
  end
end
