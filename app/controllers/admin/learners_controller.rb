class Admin::LearnersController < AdminController
  respond_to :html, :json

  def index
    @learners = Learner
      .joins("LEFT OUTER JOIN trackers AS active_trackers ON active_trackers.learner_id = learners.id 
        AND active_trackers.trashed_at IS NULL")
      .joins("LEFT OUTER JOIN trackers AS inactive_trackers ON inactive_trackers.learner_id = learners.id 
        AND inactive_trackers.trashed_at IS NOT NULL")
      .joins("LEFT OUTER JOIN achievements ON achievements.learner_id = learners.id")
      .joins("LEFT OUTER JOIN 
        ( SELECT a1.*
         FROM achievements AS a1
         LEFT JOIN achievements AS a2 ON a1.learner_id = a2.learner_id 
         AND a1.created_at < a2.created_at
         WHERE a2.learner_id IS NULL ) AS achievements_last ON achievements_last.learner_id = learners.id")
      .select("learners.*")
      .select("achievements_last.created_at AS achievement_date")
      .select("achievements_last.description AS achievement_description")
      .select("COUNT(DISTINCT active_trackers.id) AS active_count")
      .select("COUNT(DISTINCT inactive_trackers.id) AS inactive_count")
      .select("COUNT(DISTINCT achievements.id) AS achievements_count")
      .group('learners.id, achievements_last.created_at, achievements_last.description')

    respond_with @learners
  end

  def new
    @learner = Learner.new
  end

  def create
    @learner = Learner.new(learner_params)

    if @learner.save
      redirect_to admin_learners_path
    else
      render :new
    end
  end

  def edit
    @learner = Learner.find params[:id]
  end

  def update
    @learner = Learner.find params[:id]

    if @learner.update_attributes(learner_params)
      redirect_to admin_learners_path
    else
      render :edit
    end
  end

  private

  def learner_params
    params.require(:learner).permit(:name, :email, :password, :password_confirmation)
  end
end
