class LearnersController < InheritedResources::Base
  respond_to :html, :json
  actions :show, :edit, :update

  def update
    update! { profile_path }
  end

  private

  def update_resource(learner, attributes)
    super
    create_focus_positions_update_from_attributes(learner, attributes)
  end

  def create_focus_positions_update_from_attributes(learner, attributes)
    focus_positions_attributes = attributes.first["focus_positions_attributes"]
    if focus_positions_attributes
      FocusPositionsUpdate.create_for_learner_with_focus_positions_attributes!(learner, focus_positions_attributes)
    end
  end    
  
  def resource
    get_resource_ivar || set_resource_ivar(current_user)
  end

  def permitted_params
    params.permit(:learner =>
      ["name",
       "age",
       "class_year",
       "about_me",
       "about_me_as_a_learner",
       "hobbies_and_interests",
       "big_ambitions",
       "favourite_things",
       "best_thing_this_week",
       "avatar",
       focus_positions_attributes: [:id, :position]
      ]
    )
  end

  def begin_of_association_chain
    current_user
  end
end
