BemyeyesBackend::Admin.controllers :helper_requests do
  get :index do
    @title = "Helper_requests"
    @helper_requests = HelperRequest.all
    render 'helper_requests/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'helper_request')
    @helper_request = HelperRequest.new
    render 'helper_requests/new'
  end

  post :create do
    @helper_request = HelperRequest.new(params[:helper_request])
    if @helper_request.save
      @title = pat(:create_title, :model => "helper_request #{@helper_request.id}")
      flash[:success] = pat(:create_success, :model => 'HelperRequest')
      params[:save_and_continue] ? redirect(url(:helper_requests, :index)) : redirect(url(:helper_requests, :edit, :id => @helper_request.id))
    else
      @title = pat(:create_title, :model => 'helper_request')
      flash.now[:error] = pat(:create_error, :model => 'helper_request')
      render 'helper_requests/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "helper_request #{params[:id]}")
    @helper_request = HelperRequest.find(params[:id])
    if @helper_request
      render 'helper_requests/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'helper_request', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "helper_request #{params[:id]}")
    @helper_request = HelperRequest.find(params[:id])
    if @helper_request
      if @helper_request.update_attributes(params[:helper_request])
        flash[:success] = pat(:update_success, :model => 'Helper_request', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:helper_requests, :index)) :
          redirect(url(:helper_requests, :edit, :id => @helper_request.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'helper_request')
        render 'helper_requests/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'helper_request', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Helper_requests"
    helper_request = HelperRequest.find(params[:id])
    if helper_request
      if helper_request.destroy
        flash[:success] = pat(:delete_success, :model => 'Helper_request', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'helper_request')
      end
      redirect url(:helper_requests, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'helper_request', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Helper_requests"
    unless params[:helper_request_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'helper_request')
      redirect(url(:helper_requests, :index))
    end
    ids = params[:helper_request_ids].split(',').map(&:strip)
    helper_requests = HelperRequest.find(ids)
    
    if helper_requests.each(&:destroy)
    
      flash[:success] = pat(:destroy_many_success, :model => 'Helper_requests', :ids => "#{ids.to_sentence}")
    end
    redirect url(:helper_requests, :index)
  end
end
