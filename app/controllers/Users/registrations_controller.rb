class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]

  def new
    build_resource({})
    set_minimum_password_length
    resource.address = resource.address.nil? ? resource.build_address : resource.address   
  end

  # POST /resource
  def create
    build_resource(sign_up_params)
    resource.address = resource.address.nil? ? resource.build_address : resource.address   
    resource.save
    yield resource if block_given?
    if resource.persisted?
      resource.set_member
      resource.generate_sms_code
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # GET /resource/edit
  def edit
    resource.build_address if resource.address.nil?
    super
  end

  # PUT /resource
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    resource_updated = resource.update_attributes(custom_update)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) do |user_params|
      user_params.permit(:email, :password, :password_confirmation, :phone_number, :first_name, :last_name, address_attributes: [:country, :state, :city, :address, :zip_code])
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    # devise_parameter_sanitizer.for(:account_update) do |user_params|
    #   user_params.permit(:email, :phone_number, :first_name, :last_name, address_attributes: [:country, :state, :city, :address, :zip_code])
    # end
  end

  def custom_update
    if !params[:user][:password].present?
      params[:user].delete(:password)
    end
    params.require(:user).permit(:password, :email, :phone_number, :first_name, :last_name, address_attributes: [:country, :state, :city, :address, :zip_code])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
