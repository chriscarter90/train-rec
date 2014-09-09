module TrackersHelper
  def active?(tracker)
    "active" if current_page? new_tracker_achievement_path(tracker)      
  end    
end
