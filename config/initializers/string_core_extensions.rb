module Cssify
  def cssify
    downcase.strip.dasherize.gsub(/ +/, '-')
  end
end

class String
  include Cssify
end
