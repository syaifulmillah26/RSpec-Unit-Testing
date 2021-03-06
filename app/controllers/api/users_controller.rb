# frozen_string_literal: true

module Api
  # UsersController
  class UsersController < Api::ResourceController
    before_action :authenticate_user, except: :create
    before_action :set_object, only: %i[
      show update destroy activate inactivate
    ]

    def activate
      @object.update_column(:is_active, true)

      render json: @object, status: 200
    rescue StandardError => e
      render json: { message: e.message }, status: 400
    end

    def inactivate
      @object.update_column(:is_active, false)

      render json: @object, status: 200
    rescue StandardError => e
      render json: { message: e.message }, status: 400
    end
  end
end
