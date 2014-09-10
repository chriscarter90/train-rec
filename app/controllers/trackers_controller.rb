class TrackersController < InheritedResources::Base
  respond_to :html, :json
  actions :new, :create, :show, :index, :destroy
  before_filter :set_trackers, :except => [:index]
  layout 'responsive'
  
  def create
    create! { dashboard_path }
  end

  def destroy
    destroy! { dashboard_path }
  end

  private

  def destroy_resource(object)
    object.trash
  end

  def permitted_params
    params.permit(:tracker => [:name, :description, :focus_id, :subject_id, :difficulty])
  end

  def begin_of_association_chain
    current_user
  end

  def collection
    @trackers ||= super.decorate
  end

  def build_resource
    @tracker ||= super.decorate
  end
end
