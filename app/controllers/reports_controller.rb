class ReportsController < InheritedResources::Base
  respond_to :html, :json
  belongs_to :learner, instance_name: 'current_user'
  
  before_filter :set_trackers

  def create
    create! { profile_reports_url }
  end

  def update
    update! { profile_reports_url }
  end

  def new
    @foci = Focus.all
    @current_trackers = begin_of_association_chain.trackers
    @achievements = begin_of_association_chain.achievements.decorate
    new!
  end

  def edit
    @foci = Focus.all
    @current_trackers = begin_of_association_chain.trackers.where("created_at <= ?", resource.created_at)
    @achievements = begin_of_association_chain.achievements.where("created_at <= ?", resource.created_at).decorate 
    edit!
  end

  private

  def begin_of_association_chain
    current_user
  end

  def permitted_params
    params.permit(:report => [:about_me, :where_i_started, :where_i_am_now, :where_i_want_to_be, :teacher_comment])
  end

  def collection
    @reports ||= super.decorate
  end

  def resource
    @report ||= super.decorate
  end

  def build_resource
    @report ||= super.decorate
    @report.about_me ||= current_user.about_me
    
    return @report
  end

end
