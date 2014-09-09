class Admin::AchievementsController < AdminController
  respond_to :html, :json

  def index
    @achievements = Achievement.all.decorate
  end
end