BemyeyesBackend::Admin.controllers :helper_points do
  get :index do
    @title = "Helper_points"
    @helper_points = HelperPoint.all
    render 'helper_points/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'helper_point')
    @helper_point = HelperPoint.new
    render 'helper_points/new'
  end

  post :create do
    @helper_point = HelperPoint.new(params[:helper_point])
    if @helper_point.save
      @title = pat(:create_title, :model => "helper_point #{@helper_point.id}")
      flash[:success] = pat(:create_success, :model => 'HelperPoint')
      params[:save_and_continue] ? redirect(url(:helper_points, :index)) : redirect(url(:helper_points, :edit, :id => @helper_point.id))
    else
      @title = pat(:create_title, :model => 'helper_point')
      flash.now[:error] = pat(:create_error, :model => 'helper_point')
      render 'helper_points/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "helper_point #{params[:id]}")
    @helper_point = HelperPoint.find(params[:id])
    if @helper_point
      render 'helper_points/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'helper_point', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "helper_point #{params[:id]}")
    @helper_point = HelperPoint.find(params[:id])
    if @helper_point
      if @helper_point.update_attributes(params[:helper_point])
        flash[:success] = pat(:update_success, :model => 'Helper_point', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:helper_points, :index)) :
          redirect(url(:helper_points, :edit, :id => @helper_point.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'helper_point')
        render 'helper_points/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'helper_point', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Helper_points"
    helper_point = HelperPoint.find(params[:id])
    if helper_point
      if helper_point.destroy
        flash[:success] = pat(:delete_success, :model => 'Helper_point', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'helper_point')
      end
      redirect url(:helper_points, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'helper_point', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Helper_points"
    unless params[:helper_point_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'helper_point')
      redirect(url(:helper_points, :index))
    end
    ids = params[:helper_point_ids].split(',').map(&:strip)
    helper_points = HelperPoint.find(ids)
    
    if helper_points.each(&:destroy)
    
      flash[:success] = pat(:destroy_many_success, :model => 'Helper_points', :ids => "#{ids.to_sentence}")
    end
    redirect url(:helper_points, :index)
  end
end
