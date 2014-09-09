class Learner < ActiveRecord::Base
  has_secure_password
  validates :password, presence: true, :on => :create
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  has_many :achievements
  has_many :trackers
  has_many :focus_positions
  has_many :focus_positions_updates
  has_many :reports

  accepts_nested_attributes_for :focus_positions
  
  mount_uploader :avatar, AvatarUploader

  def self.anonymous
    find_by_email("anonymous@example.com") || create_anonymous!
  end

  def initialize_focus_positions!
    Focus.all.each do |focus|
      unless focus_positions.find_by_focus_id(focus.id)
        focus_positions.create!(focus: focus, position: FocusPosition::DEFAULT_POSITION)
      end
    end
  end
  
  private

  def self.create_anonymous!
    create!(name: "Anonymous",
            email: "anonymous@example.com",
            password: "Malice7Verse+whig",
            password_confirmation: "Malice7Verse+whig")
  end
end
