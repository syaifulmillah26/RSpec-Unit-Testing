# frozen_string_literal: true

module Api
  # resource class
  class ResourceController < Api::ApplicationController
    before_action :authenticate_user
    before_action :set_object, only: %i[show update destroy]
    helper_method :permitted_resource_params

    def index
      objects = model_class.all

      render json: objects, status: 200
    rescue StandardError => e
      render json: { message: e.message }, status: 400
    end

    def new
      render model_class.new
    end

    def create
      @object = model_class.new(permitted_resource_params)
      @object.save!

      data = { message: t('officer.success'), data: @object }
      render json: data, status: 201
    rescue StandardError => e
      render json: { error: e.message }, status: 400
    end

    def show
      data = { message: t('officer.success'), data: @object }
      render json: data, status: 200
    rescue StandardError => e
      render json: { error: e.message }, status: 400
    end

    def update
      @object.update!(permitted_resource_params)

      data = { message: t('officer.success'), data: @object }
      render json: data, status: 200
    rescue StandardError => e
      render json: { error: e.message }, status: 400
    end

    def destroy
      @object.destroy!
      render json: { message: t('officer.success') }, status: :ok
    rescue StandardError => e
      render json: { error: e.message }, status: 400
    end

    private

    def set_object
      @object = model_class.find(params[:id])
    rescue StandardError => e
      render json: { error: e.message }, status: 400
    end

    def permitted_resource_params
      acp = ActionController::Parameters.new.permit!
      params[object_name].present? ? params.require(object_name).permit! : acp
    end

    def model_class
      controller_name.classify.to_s.constantize
    end

    def object_name
      controller_name.singularize
    end
  end
end
