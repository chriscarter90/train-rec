class FocusPosition < ActiveRecord::Base
  validates :focus, presence: true
  validates :learner, presence: true
  validates :position, :inclusion => { :in => 0..1 }
  
  belongs_to :focus
  belongs_to :learner

  DEFAULT_POSITION = 0.5
end
