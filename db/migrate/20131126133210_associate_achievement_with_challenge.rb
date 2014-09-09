class AssociateAchievementWithChallenge < ActiveRecord::Migration
  def change
    add_column :achievements, :challenge_id, :integer
  end
end
