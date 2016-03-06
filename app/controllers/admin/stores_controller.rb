class Admin::StoresController < Admin::ApplicationController

  def index
    @stores = Store.order(:name).page(params[:page]).per(25)
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)
    @created = @store.save
    respond_to do |f|
      f.html{redirect_to new_admin_store_path}
      f.js{
        if @created
          flash.now[:notice] = 'Succesfully created'
        else
          flash.now[:error] = 'Create new store failed'
        end
      }
    end
  end

  def edit
    @store = Store.friendly.find(params[:id])
  end

  def update
    @store = Store.friendly.find(params[:id])
    @updated = @store.update_attributes(store_params)
    respond_to do |f|
      f.html {redirect_to edit_admin_store_path(@store)}
      f.js {
      	if @updated
        	flash.now[:notice] = 'Succesfully updated'
        else
        	flash.now[:error] = 'Update failed'
        end
      }
    end
  end

  def destroy
    @store = Store.friendly.find(params[:id])
    @store.destroy
    redirect_to :back  
  end

  private
  def store_params
    params.require(:store).permit(:name, :address, :phone_number, :password)
  end
end