class ApplicationController < ActionController::API
  class NoRecordError < StandardError; end
  rescue_from NoRecordError, with: :authentication_standard_error

  private
  def raw_params
    @raw_params ||= JSON.parse(request.raw_post).with_indifferent_access
  end

  def authentication_standard_error
    error = {
      "status" => "404",
      "source" => { "pointer" => "/data/attributes/code" },
      "title" =>  "Invalid Reservation code",
      "detail" => "You must provide valid code in order to update Reservation."
    }
    render json: { "errors": [ error ] }, status: 404
  end
end
