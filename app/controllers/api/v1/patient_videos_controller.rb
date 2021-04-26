class Api::V1::PatientVideosController < Api::V1::BaseController
  def video
    resource_id = params[:id]
    resource = resource_klass.find_by_key(resource_id, context: context)

    begin
      ::Pundit.authorize(context[:user], resource._model, 'video?')

      send_file resource._model.video.current_path, disposition: 'inline'
    rescue Pundit::NotAuthorizedError
      user_not_authorized
    end
  end
end