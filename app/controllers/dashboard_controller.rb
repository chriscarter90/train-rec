class DashboardController < ApplicationController
  before_filter :set_trackers, :set_achievements
  layout 'responsive'
end
