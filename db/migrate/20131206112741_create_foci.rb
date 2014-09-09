class CreateFoci < ActiveRecord::Migration
  def change
    create_table :foci do |t|
      t.string :name
      
      t.timestamps
    end

    add_index :foci, :name, unique: true
  end
end
