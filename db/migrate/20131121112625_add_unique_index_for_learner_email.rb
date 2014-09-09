class AddUniqueIndexForLearnerEmail < ActiveRecord::Migration
  def change
    add_index :learners, :email, unique: true
  end
end
