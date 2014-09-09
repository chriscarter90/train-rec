class Tracker < ActiveRecord::Base
  include Trashable

  DIFFICULTIES = {
    easy: 10,
    medium: 50,
    hard: 250
  }

  validates :name, presence: true
  validates :learner, presence: true
  validates_length_of :name, :maximum => 255

  belongs_to :learner
  belongs_to :focus
  belongs_to :subject
  has_many :achievements

  default_scope { order(created_at: :desc) }

  scope :with_focus, ->(focus) { where(focus: focus) }

  Tracker::DIFFICULTIES.keys.each do |difficulty|
    scope difficulty, -> { where(difficulty: difficulty) }
  end

  Tracker::DIFFICULTIES.keys.each do |method|
    define_method("#{method}?") { self.difficulty == method.to_s }
  end 

end
