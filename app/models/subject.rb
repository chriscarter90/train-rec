class Subject < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :challenges
  has_many :achievements  

  UNDEFINED_NAME = "No subject"

  default_scope { order(name: :asc) }

  def self.select_options
    options = Subject.all.collect { |f| [ f.name, f.id ] }
    [[UNDEFINED_NAME, nil]] + options
  end
end
