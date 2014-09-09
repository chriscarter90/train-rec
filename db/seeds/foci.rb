class Learner < ActiveRecord::Base
end

puts "* Seeding foci"
data = YAML.load_file(Rails.root.join("db", "seeds", "foci.yml"))
data.each do |focus_name|
  unless Focus.find_by_name(focus_name)
    puts "Adding focus: #{focus_name}"
    Focus.create!(name: focus_name)
  end
end
