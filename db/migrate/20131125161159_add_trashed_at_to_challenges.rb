class AddTrashedAtToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :trashed_at, :datetime
  end
end
