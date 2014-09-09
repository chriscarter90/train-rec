class FocusPositionsController < InheritedResources::Base
  respond_to :html, :json
  actions :index
  before_filter :set_trackers

  def index
    current_user.initialize_focus_positions!
    super
  end
end
