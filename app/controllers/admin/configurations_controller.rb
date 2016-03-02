class Admin::ConfigurationsController < Admin::ApplicationController

  def edit
    AppConfiguration.create! if AppConfiguration.count.zero?
    @setting = AppConfiguration.last 
  end

  def update
    @setting = AppConfiguration.last
    if @setting.update_attributes(setting_params)
    	redirect_to admin_settings_path, notice: 'Setting updated!'
    else
      render :edit
    end
  end

  def setting_params
    params.require(:app_configuration).permit!
  end
end