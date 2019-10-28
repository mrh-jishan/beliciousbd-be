module ExceptionHandler
    extend ActiveSupport::Concern

    included do
      rescue_from ActiveRecord::RecordNotFound do |e|
        json_response({success: false,message: e.message}, 404)
      end

      rescue_from ActiveRecord::RecordInvalid do |e|
        json_response({success: false,message: e.message}, 422)
      end

      rescue_from StandardError do |e|
        json_response({success: false,message: e.message}, 500)
      end
    end
end