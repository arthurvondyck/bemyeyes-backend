BemyeyesBackend::Admin.controllers :devices do
  get :index do
    @title = "Devices"
    @devices = Device.all
    render 'devices/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'device')
    @device = Device.new
    render 'devices/new'
  end

  post :create do
    @device = Device.new(params[:device])
    if @device.save
      @title = pat(:create_title, :model => "device #{@device.id}")
      flash[:success] = pat(:create_success, :model => 'Device')
      params[:save_and_continue] ? redirect(url(:devices, :index)) : redirect(url(:devices, :edit, :id => @device.id))
    else
      @title = pat(:create_title, :model => 'device')
      flash.now[:error] = pat(:create_error, :model => 'device')
      render 'devices/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "device #{params[:id]}")
    @device = Device.find(params[:id])
    if @device
      render 'devices/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'device', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "device #{params[:id]}")
    @device = Device.find(params[:id])
    if @device
      if @device.update_attributes(params[:device])
        flash[:success] = pat(:update_success, :model => 'Device', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:devices, :index)) :
          redirect(url(:devices, :edit, :id => @device.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'device')
        render 'devices/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'device', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Devices"
    device = Device.find(params[:id])
    if device
      if device.destroy
        flash[:success] = pat(:delete_success, :model => 'Device', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'device')
      end
      redirect url(:devices, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'device', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Devices"
    unless params[:device_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'device')
      redirect(url(:devices, :index))
    end
    ids = params[:device_ids].split(',').map(&:strip)
    devices = Device.find(ids)
    
    if devices.each(&:destroy)
    
      flash[:success] = pat(:destroy_many_success, :model => 'Devices', :ids => "#{ids.to_sentence}")
    end
    redirect url(:devices, :index)
  end
end
