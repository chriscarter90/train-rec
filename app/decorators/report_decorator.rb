class ReportDecorator < ApplicationDecorator
  delegate_all

  def name
    date = new_record? ? Date.today : created_at
    "Report " + date.strftime("%B #{date.day.ordinalize} %Y - %H:%M")
  end
end
