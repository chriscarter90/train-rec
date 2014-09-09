class Achievement < ActiveRecord::Base
end

class Challenge < ActiveRecord::Base
end

class AssignChallengesAndAchievementsToALearner < ActiveRecord::Migration
  def up
    add_column :challenges, :learner_id, :integer
    add_column :achievements, :learner_id, :integer

    if Challenge.count + Achievement.count > 0
    
      default_learner = Learner.anonymous

      ActiveRecord::Base.connection.execute("UPDATE challenges SET learner_id=#{default_learner.id}")
      ActiveRecord::Base.connection.execute("UPDATE achievements SET learner_id=#{default_learner.id}")
    end
  end

  def down
    remove_column :challenges, :learner_id
    remove_column :achievements, :learner_id
  end
end
