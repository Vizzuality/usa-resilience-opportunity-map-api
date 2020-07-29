class ApiController < ApplicationController
  include JSONAPI::ActsAsResourceController

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found
    render json: { errors:
                       [JSONAPI::Error.new(
                           code: JSONAPI::RECORD_NOT_FOUND,
                           status: :not_found,
                           title: 'Record not found'
                       )] }, status: 404
  end

  def context
    super.merge(base_url: base_url)
  end
end
