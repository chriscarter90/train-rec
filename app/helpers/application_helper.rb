module ApplicationHelper
  def pretty_date(date)
    return "N/A" unless date
    date.strftime("%b #{date.day.ordinalize} %Y")
  end
end
