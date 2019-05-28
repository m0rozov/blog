class ApplicationController < ActionController::API
  def respond_with_200(data = nil)
    render json: {
      payload: data
    }, status: 200
  end

  def respond_with_422(errors)
    render json: {
      errors: {
        status: 422,
        title: 'Validation Failed',
        source: errors
      },
    }, status: 422
  end
end
