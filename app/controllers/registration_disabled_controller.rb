class RegistrationDisabledController < DeviseInvitable::RegistrationsController
  def new
    flash[:info] = 'Registrations are disabled at the moment'
    redirect_to root_path
  end

  def create
    flash[:info] = 'Registrations are disabled at the moment'
    redirect_to root_path
  end
end