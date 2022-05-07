class Admin::ConfirmationsController < Devise::ConfirmationsController
  private

  def after_confirmation_path_for(resource_name, resource)
    return patient_confirmation_path if resource.patient?
    
    super(resource_name, resource)
  end
end