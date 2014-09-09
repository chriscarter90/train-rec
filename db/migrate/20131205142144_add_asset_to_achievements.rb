class AddAssetToAchievements < ActiveRecord::Migration
  def change
    add_column :achievements, :asset, :string
  end
end
