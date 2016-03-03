class Admin::ConfigurationsController < Admin::ApplicationController

  def edit
    AppConfiguration.create! if AppConfiguration.count.zero?
    @setting = AppConfiguration.current_config 
  end

  def update
    @setting = AppConfiguration.current_config
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