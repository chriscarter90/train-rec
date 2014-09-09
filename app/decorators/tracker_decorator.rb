class TrackerDecorator < ApplicationDecorator
  delegate_all

  def difficulty
    object.difficulty || 'medium'
  end

  def active?
    bool = !trashed_at?
    bool.to_s.humanize
  end
  
end  
