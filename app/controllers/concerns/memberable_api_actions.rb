module MemberableApiActions
  extend ActiveSupport::Concern

  class_methods do
    def memberable_api_actions(actions:)
      actions.each do | action |
        action_name = action.to_s.gsub('!', '')

        define_method action_name do
          resource_id = params[:id]
          resource = resource_klass.find_by_key(resource_id, context: context)

          begin
            ::Pundit.authorize(context[:user], resource._model, "#{action_name}?")

            if resource._model.send(action)
              jsonapi_render json: resource._model, status: :ok
            else
              jsonapi_render_errors json: resource._model, status: :unprocessable_entity
            end
          rescue Pundit::NotAuthorizedError
            user_not_authorized
          end
        end
      end
    end
  end
end