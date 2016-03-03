class Admin::UsersController < Admin::ApplicationController

  def index  	
  	@users = User.members.order(created_at: :desc)
  	if params[:status].present?
      @users.where(status: params[:status])
  	end
  	@users = @users.page(params[:page]).per(25)
  end

  def new
    @user = User.new
    @user.build_address
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash.now[:notice] = "Successfully created."
    end
    respond_to do |f|
      f.html{}
      f.js{}
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy if @user
    redirect_to :back
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user.update_attributes(user_params)
      flash.now[:notice] = "Successfully updated."
    end
    respond_to do |f|
      f.html {}
      f.js {}
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
    respond_to do |f|
      f.html {}
      f.js {}
    end
  end

  def trades
    @user = User.find_by_id(params[:id])
    @trades = @user.trades.order(created_at: :desc).page(params[:page]).per(20)
    respond_to do |f|
      f.html {}
      f.js {}
    end
  end

  def login_histories
    @user = User.find_by_id(params[:id])
    @login_histories = @user.login_histories.order(created_at: :desc).page(params[:page]).per(20)
    respond_to do |f|
      f.html {}
      f.js {}
    end
  end

  def status
    @user = User.find_by_id(params[:id])
  end

  def change_status
    @user = User.find_by_id(params[:id])
    @state = @user.update_attributes(status: params[:user][:status])
    puts @state.inspect
    puts "=" * 100
  end

  private
  def user_params
    if !params[:user][:password].present? && @user
      params[:user].delete(:password)
    end
    params.require(:user).permit(:password_confirmation, :password, :email, :phone_number, :first_name, :last_name, address_attributes: [:country, :state, :city, :address, :zip_code])
  end
end