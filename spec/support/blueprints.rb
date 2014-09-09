require 'machinist/active_record'

Achievement.blueprint do
  name { "Create an achievement blueprint" }
  description { "Create an achievement blueprint" }
  learner
end

Tracker.blueprint do
  name { "Create a tracker blueprint" }
  learner
end

Focus.blueprint do
  name { "Testing-#{sn}" }
end

FocusPosition.blueprint do
  learner
  focus
  position { FocusPosition::DEFAULT_POSITION }
end

FocusPositionsUpdate.blueprint do
  learner
end

Report.blueprint do
  learner
end

Subject.blueprint do
  name { "Testing-#{sn}" }
end

Learner.blueprint do
  password { "letmein" }
  password_confirmation { "letmein" }
  name { "learner" }
  email { "learner-#{sn}@example.com" }
end
