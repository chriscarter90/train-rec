module DashboardHelper
  def filter_options
    Focus.all.collect do |f|
      [ f.name, f.id ]
    end.unshift(['Show all', ''])
  end

  def default_filter_option
    params[:focus_id] || ''
  end
end
