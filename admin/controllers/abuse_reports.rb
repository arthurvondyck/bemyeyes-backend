BemyeyesBackend::Admin.controllers :abuse_reports do
  get :index do
    @title = "Abuse_reports"
    @abuse_reports = AbuseReport.all
    render 'abuse_reports/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'abuse_report')
    @abuse_report = AbuseReport.new
    render 'abuse_reports/new'
  end

  post :create do
    @abuse_report = AbuseReport.new(params[:abuse_report])
    if @abuse_report.save
      @title = pat(:create_title, :model => "abuse_report #{@abuse_report.id}")
      flash[:success] = pat(:create_success, :model => 'AbuseReport')
      params[:save_and_continue] ? redirect(url(:abuse_reports, :index)) : redirect(url(:abuse_reports, :edit, :id => @abuse_report.id))
    else
      @title = pat(:create_title, :model => 'abuse_report')
      flash.now[:error] = pat(:create_error, :model => 'abuse_report')
      render 'abuse_reports/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "abuse_report #{params[:id]}")
    @abuse_report = AbuseReport.find(params[:id])
    if @abuse_report
      render 'abuse_reports/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'abuse_report', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "abuse_report #{params[:id]}")
    @abuse_report = AbuseReport.find(params[:id])
    if @abuse_report
      if @abuse_report.update_attributes(params[:abuse_report])
        flash[:success] = pat(:update_success, :model => 'Abuse_report', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:abuse_reports, :index)) :
          redirect(url(:abuse_reports, :edit, :id => @abuse_report.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'abuse_report')
        render 'abuse_reports/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'abuse_report', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Abuse_reports"
    abuse_report = AbuseReport.find(params[:id])
    if abuse_report
      if abuse_report.destroy
        flash[:success] = pat(:delete_success, :model => 'Abuse_report', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'abuse_report')
      end
      redirect url(:abuse_reports, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'abuse_report', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Abuse_reports"
    unless params[:abuse_report_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'abuse_report')
      redirect(url(:abuse_reports, :index))
    end
    ids = params[:abuse_report_ids].split(',').map(&:strip)
    abuse_reports = AbuseReport.find(ids)
    
    if abuse_reports.each(&:destroy)
    
      flash[:success] = pat(:destroy_many_success, :model => 'Abuse_reports', :ids => "#{ids.to_sentence}")
    end
    redirect url(:abuse_reports, :index)
  end
end
