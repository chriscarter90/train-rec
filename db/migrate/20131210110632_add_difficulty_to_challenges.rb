class AddDifficultyToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :difficulty, :string
  end
end
