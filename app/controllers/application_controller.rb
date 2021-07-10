class ApplicationController < ActionController::Base
  def t(data)
    I18n.t(data)
  end
end
