class AdminController < ApplicationController
  skip_before_filter :authorize
  before_filter :authenticate_admin!

  layout 'admin'

  def show
    
  end

  private

  def authenticate_admin!
    authenticate_or_request_with_http_basic do |username, password|
      username == "admin" && password == "Device_Crater8safety"
    end
  end
end