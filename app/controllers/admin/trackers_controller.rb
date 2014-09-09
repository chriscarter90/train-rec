class Admin::TrackersController < AdminController
  respond_to :html, :json

  def index
    @trackers = Tracker.unscoped.joins("LEFT OUTER JOIN achievements ON achievements.tracker_id = trackers.id")
    .joins("LEFT OUTER JOIN (
      SELECT a1.*
      FROM achievements as a1
      LEFT JOIN achievements as a2
        ON a1.tracker_id = a2.tracker_id AND a1.created_at < a2.created_at
      WHERE a2.tracker_id IS NULL
      ) as achievements_last ON achievements_last.tracker_id = trackers.id")
    .select("trackers.*")
    .select("achievements_last.created_at as achievement_date")
    .select("COUNT(DISTINCT achievements.id) as achievements_count")
    .group('trackers.id')
    .includes(:focus, :learner)
    .decorate

    respond_with @trackers
  end
end
