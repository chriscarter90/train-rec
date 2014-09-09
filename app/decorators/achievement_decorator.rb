class AchievementDecorator < ApplicationDecorator
  delegate_all

  def created_at
    date.strftime("%b #{date.day.ordinalize}")
  end

  private

  def date
    object.created_at
  end

end
