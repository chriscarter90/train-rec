class AchievementsController < InheritedResources::Base
  layout 'responsive'
  respond_to :html, :json
  actions :new, :create, :index, :destroy, :update
  belongs_to :tracker, optional: true
  before_filter :set_trackers

  def create
    create! do |success, failure|
      success.html { redirect_to dashboard_path }
      failure.html { redirect_to dashboard_path }
    end
  end

  def destroy
    destroy! do |format|
      format.js { head :ok }
    end
  end

  private

  # build_resource is called by InheritedResources on the :new and :create
  # actions. However, we only want to set the name of focus on :new.
  def build_resource
    super

    if parent && action_name == 'new'
      resource.name ||= parent.name
      resource.focus_id ||= parent.focus_id
      resource.subject_id ||= parent.subject_id
      @achievements = resource.tracker.achievements.decorate
    end

    resource
  end

  def destroy_resource(object)
    object.trash
  end

  def permitted_params
    params.permit(:achievement => [:name, :description, :tracker_id, :asset, :focus_id, :subject_id])
  end

  def begin_of_association_chain
    current_user
  end

  def collection
    @achievements ||= end_of_association_chain.focus(params[:focus_id]).decorate
  end

end
