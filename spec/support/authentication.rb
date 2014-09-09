module AuthHelper
  def sign_in(user)
    session[:learner_id] = user.id
  end  

  def admin_login
    user = 'admin'
    pw = 'Device_Crater8safety'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end
end

module AuthRequestHelper
  def admin_login
    name = 'admin'
    password = 'Device_Crater8safety'

    if page.driver.respond_to?(:basic_auth)
      page.driver.basic_auth(name, password)
    elsif page.driver.respond_to?(:basic_authorize)
      page.driver.basic_authorize(name, password)
    elsif page.driver.respond_to?(:browser) && page.driver.browser.respond_to?(:basic_authorize)
      page.driver.browser.basic_authorize(name, password)
    end
  end
end

RSpec.configure do |config|
  config.include AuthHelper, :type => :controller
  config.include AuthRequestHelper, :type => :feature
end