class FocusPositionsUpdate < ActiveRecord::Base
  validates :learner, presence: true

  belongs_to :learner

  serialize :data

  def self.create_for_learner_with_focus_positions_attributes!(learner, focus_positions_attributes)
    data = {}
    focus_positions_attributes.each do |id, attributes|
      data[attributes["id"].to_i] = attributes["position"].to_f
    end

    create!(learner: learner, data: data)
  end
end
