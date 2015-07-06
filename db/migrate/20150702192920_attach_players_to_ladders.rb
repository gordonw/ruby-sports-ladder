class AttachPlayersToLadders < ActiveRecord::Migration
  def change
    change_table :players do |t|
      t.belongs_to :ladder, index: true
    end
  end
end


