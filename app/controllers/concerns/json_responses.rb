module JsonResponses
  extend ActiveSupport::Concern

  private

  def render_error_response(message, data = {})
    render_response(message, :bad_request, data)
  end

  def render_success_response(message, data = {})
    render_response(message, :created, data)
  end

  def render_not_found_response(message)
    render_response(message, :not_found)
  end

  def render_response(message, code, data = {})
    render json: { responseMessage: message, data: data }, status: code
  end
end
