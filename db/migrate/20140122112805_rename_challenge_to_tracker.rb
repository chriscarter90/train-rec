class RenameChallengeToTracker < ActiveRecord::Migration
  def change
    rename_table('challenges', 'trackers')
    rename_column :achievements, :challenge_id, :tracker_id
  end
end
