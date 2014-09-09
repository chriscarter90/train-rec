class AddBioFieldsToLearner < ActiveRecord::Migration
  def change
  	add_column :learners, :age, :integer
  	add_column :learners, :class_year, :string
  	add_column :learners, :about_me, :text
  	add_column :learners, :about_me_as_a_learner, :text
  	add_column :learners, :hobbies_and_interests, :text
  	add_column :learners, :big_ambitions, :text
  	add_column :learners, :favourite_things, :text
  	add_column :learners, :best_thing_this_week, :text
  end
end
