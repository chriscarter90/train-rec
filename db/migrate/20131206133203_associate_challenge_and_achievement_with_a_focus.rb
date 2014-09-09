class AssociateChallengeAndAchievementWithAFocus < ActiveRecord::Migration
  def change
    add_column :challenges, :focus_id, :integer
    add_column :achievements, :focus_id, :integer
  end
end
