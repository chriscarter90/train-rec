class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authorize

  private

  def current_user
    @current_user ||= Learner.find(session[:learner_id]).decorate if session[:learner_id]
  end
  helper_method :current_user

  def authorize
    redirect_to login_path, alert: "Not authorized" if current_user.nil?
  end

  def set_trackers
    @trackers ||
      begin
        # The reason we get trackers in this convulated way is that
        # the controller uses inherited resources to automatically
        # scope them under the current user. We only want our security
        # to be in one place so I consider this the least bad way to
        # do this. In future this will also automatically make
        # filtering work.
        trackers_controller = TrackersController.new
        trackers_controller.request = request
        @trackers = trackers_controller.send(:collection)
      end
  end

  def set_achievements
    @achievements ||
      begin
        # The reason we get achievements in this convulated way is that
        # the controller uses inherited resources to automatically
        # scope them under the current user. We only want our security
        # to be in one place so I consider this the least bad way to
        # do this. In future this will also automatically make
        # filtering work.
        achievements_controller = AchievementsController.new
        achievements_controller.request = request
        @achievements = achievements_controller.send(:collection)
      end
  end
end
