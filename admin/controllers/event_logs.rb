BemyeyesBackend::Admin.controllers :event_logs do
  get :index do
    @title = "Event_logs"
    @event_logs = EventLog.all
    render 'event_logs/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'event_log')
    @event_log = EventLog.new
    render 'event_logs/new'
  end

  post :create do
    @event_log = EventLog.new(params[:event_log])
    if @event_log.save
      @title = pat(:create_title, :model => "event_log #{@event_log.id}")
      flash[:success] = pat(:create_success, :model => 'EventLog')
      params[:save_and_continue] ? redirect(url(:event_logs, :index)) : redirect(url(:event_logs, :edit, :id => @event_log.id))
    else
      @title = pat(:create_title, :model => 'event_log')
      flash.now[:error] = pat(:create_error, :model => 'event_log')
      render 'event_logs/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "event_log #{params[:id]}")
    @event_log = EventLog.find(params[:id])
    if @event_log
      render 'event_logs/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'event_log', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "event_log #{params[:id]}")
    @event_log = EventLog.find(params[:id])
    if @event_log
      if @event_log.update_attributes(params[:event_log])
        flash[:success] = pat(:update_success, :model => 'Event_log', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:event_logs, :index)) :
          redirect(url(:event_logs, :edit, :id => @event_log.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'event_log')
        render 'event_logs/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'event_log', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Event_logs"
    event_log = EventLog.find(params[:id])
    if event_log
      if event_log.destroy
        flash[:success] = pat(:delete_success, :model => 'Event_log', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'event_log')
      end
      redirect url(:event_logs, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'event_log', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Event_logs"
    unless params[:event_log_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'event_log')
      redirect(url(:event_logs, :index))
    end
    ids = params[:event_log_ids].split(',').map(&:strip)
    event_logs = EventLog.find(ids)
    
    if event_logs.each(&:destroy)
    
      flash[:success] = pat(:destroy_many_success, :model => 'Event_logs', :ids => "#{ids.to_sentence}")
    end
    redirect url(:event_logs, :index)
  end
end
