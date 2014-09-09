class CreateLearners < ActiveRecord::Migration
  def change
    create_table :learners do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
