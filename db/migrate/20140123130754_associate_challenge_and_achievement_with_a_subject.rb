class AssociateChallengeAndAchievementWithASubject < ActiveRecord::Migration
  def change
    add_column :trackers, :subject_id, :integer
    add_column :achievements, :subject_id, :integer
  end
end
