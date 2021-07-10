# frozen_string_literal: true

module Api
  # ApplicationController
  class ApplicationController < ActionController::API
    include Knock::Authenticable

    def t(data)
      I18n.t(data)
    end
  end
end
