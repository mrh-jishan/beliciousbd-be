module Response
  def json_response(object, status = 200, message = '')
    render json: {
        data: object,
        success: (status == 200 || status == 201),
        message: message,
        code: status,
        time: Time.now.utc
    }, status: status
  end
end