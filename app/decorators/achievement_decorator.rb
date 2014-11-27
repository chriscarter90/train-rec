class AchievementDecorator < ApplicationDecorator
  delegate_all

  def created_at
    date
  end

  private

  def date
    object.created_at
  end

end
