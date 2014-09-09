class ChangeDescriptionToText < ActiveRecord::Migration
  def change
    change_column :achievements, :description, :text
    change_column :challenges, :description, :text
  end
end
