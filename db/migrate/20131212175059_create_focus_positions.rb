class CreateFocusPositions < ActiveRecord::Migration
  def change
    create_table :focus_positions do |t|
      t.references :focus, index: true
      t.references :learner, index: true
      t.float :position

      t.timestamps
    end
  end
end
