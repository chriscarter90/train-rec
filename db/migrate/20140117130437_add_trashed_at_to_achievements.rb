class AddTrashedAtToAchievements < ActiveRecord::Migration
  def change
    add_column :achievements, :trashed_at, :datetime
  end
end
