class ApplicationController < ActionController::API
  def root
    render json: { message: 'API is running', status: 'ok' }
  end
end
