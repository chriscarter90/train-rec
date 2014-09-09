class CreateFocusPositionsUpdates < ActiveRecord::Migration
  def change
    create_table :focus_positions_updates do |t|
      t.references :learner, index: true
      t.text :data

      t.timestamps
    end
  end
end
