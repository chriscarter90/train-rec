# To add learners to the system:
# 1) Add their name and email to db/seeds/learners.yml
# 2) Run the password generation script `bundle exec bin/generate_passwords`
# 3) Take note of the generated passwords: the learners need to be notified of these
# 4) Copy the yml code output by the script to overwrite that in db/seeds/learners.yml
# 5) `bundle exec rake db:seed`
# 6) Commit changes to the repository

# To change a learners password:
# 1) Remove their password_digest entry from db/seeds/learners.yml
# Follow the same steps as for adding a learner from step 2)

class Learner < ActiveRecord::Base
end

puts "* Seeding learners"
data = YAML.load_file(Rails.root.join("db", "seeds", "learners.yml"))
data.each do |learner|
  unless Learner.find_by_email(learner[:email])
    learner = Learner.new(learner)
    learner.name = learner[:name] || raise("No name set for learner #{learner[:email]}")
    puts "Creating #{learner[:name]}"
    learner.password_digest = learner[:password_digest] || raise("No password set for learner #{learner[:email]}")
    learner.save!
  else
    puts "Already exists: #{learner[:name]}"
  end
end
