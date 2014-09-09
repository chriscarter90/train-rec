class Achievement < ActiveRecord::Base
  include Trashable
  
  validates :learner, presence: true

  belongs_to :learner
  belongs_to :tracker
  belongs_to :focus
  belongs_to :subject

  validates_length_of :name, :maximum => 255
  validates_presence_of :description

  validates_length_of :name, :maximum => 255
  validates_presence_of :description

  # We tried a before_save. It did NOT work </shake_fist>
  before_validation :when_parent_is_tracker_use_its_learner, on: :create

  mount_uploader :asset, AssetUploader

  default_scope { order(created_at: :desc) }

  def self.focus(focus_id=nil)
    focus_id.present? ? where(focus_id: focus_id) : all
  end

  def self.before(resource=nil)
    resource.created_at.present? ? where("created_at <= ?", date) : all
  end

  private

  def when_parent_is_tracker_use_its_learner
    if tracker
      self.learner = tracker.learner
    end
  end
end
