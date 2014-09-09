class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :learner, index: true
      t.text :about_me
      t.text :where_i_started
      t.text :where_i_am_now
      t.text :where_i_want_to_be
      t.text :teacher_comment

      t.timestamps
    end
  end
end
