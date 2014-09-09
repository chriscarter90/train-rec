class Focus < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :trackers
  has_many :achievements
  has_many :focus_positions

  UNDEFINED_NAME = "General"
  
  default_scope { order(name: :asc) }

  def self.select_options
    options = Focus.all.collect { |f| [ f.name, f.id ] }
    [[UNDEFINED_NAME, nil]] + options
  end
end
