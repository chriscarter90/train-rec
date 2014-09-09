class FocusPositionsUpdatesController < InheritedResources::Base
  respond_to :html, :json
  actions :index
  belongs_to :learner, instance_name: 'current_user'
  before_filter :set_trackers

  def index
    @foci = Focus.all
    @ids = begin_of_association_chain.focus_positions.map(&:id)
  end

  protected

  def begin_of_association_chain
    current_user
  end
end
