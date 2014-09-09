class Report < ActiveRecord::Base
  belongs_to :learner

  default_scope { order(created_at: :desc) }
end
