class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

private

  def respond_with_CRUD_json_response(object, options = {})
    errors_present = object.errors.present?
    error_messages = object.errors.full_messages
    failure        = (errors_present or !object.valid?)
    resp = {
      :success                                    => (failure ? 0 : 1),
      "#{object.class.name.underscore}_id".to_sym => object.id,
      "#{object.class.name.underscore}"           => failure ? nil : object
    }
    resp.merge!({ :errors => error_messages }) if errors_present
    resp.merge!(options)
    render :json => resp
  end
  
end
