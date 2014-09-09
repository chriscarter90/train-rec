class Learner < ActiveRecord::Base
end

puts "* Seeding subjects"
data = YAML.load_file(Rails.root.join("db", "seeds", "subjects.yml"))
data.each do |subject_name|
  unless Subject.find_by_name(subject_name)
    puts "Adding subject: #{subject_name}"
    Subject.create!(name: subject_name)
  end
end
