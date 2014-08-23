BemyeyesBackend::Admin.controllers :requests do
  get :index do
    @title = "Requests"
    @requests = Request.all
    render 'requests/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'request')
    @request = Request.new
    render 'requests/new'
  end

  post :create do
    @request = Request.new(params[:request])
    if @request.save
      @title = pat(:create_title, :model => "request #{@request.id}")
      flash[:success] = pat(:create_success, :model => 'Request')
      params[:save_and_continue] ? redirect(url(:requests, :index)) : redirect(url(:requests, :edit, :id => @request.id))
    else
      @title = pat(:create_title, :model => 'request')
      flash.now[:error] = pat(:create_error, :model => 'request')
      render 'requests/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "request #{params[:id]}")
    @request = Request.find(params[:id])
    if @request
      render 'requests/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'request', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "request #{params[:id]}")
    @request = Request.find(params[:id])
    if @request
      if @request.update_attributes(params[:request])
        flash[:success] = pat(:update_success, :model => 'Request', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:requests, :index)) :
          redirect(url(:requests, :edit, :id => @request.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'request')
        render 'requests/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'request', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Requests"
    request = Request.find(params[:id])
    if request
      if request.destroy
        flash[:success] = pat(:delete_success, :model => 'Request', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'request')
      end
      redirect url(:requests, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'request', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Requests"
    unless params[:request_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'request')
      redirect(url(:requests, :index))
    end
    ids = params[:request_ids].split(',').map(&:strip)
    requests = Request.find(ids)
    
    if requests.each(&:destroy)
    
      flash[:success] = pat(:destroy_many_success, :model => 'Requests', :ids => "#{ids.to_sentence}")
    end
    redirect url(:requests, :index)
  end
end
