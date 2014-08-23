BemyeyesBackend::Admin.controllers :reset_password_tokens do
  get :index do
    @title = "Reset_password_tokens"
    @reset_password_tokens = ResetPasswordToken.all
    render 'reset_password_tokens/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'reset_password_token')
    @reset_password_token = ResetPasswordToken.new
    render 'reset_password_tokens/new'
  end

  post :create do
    @reset_password_token = ResetPasswordToken.new(params[:reset_password_token])
    if @reset_password_token.save
      @title = pat(:create_title, :model => "reset_password_token #{@reset_password_token.id}")
      flash[:success] = pat(:create_success, :model => 'ResetPasswordToken')
      params[:save_and_continue] ? redirect(url(:reset_password_tokens, :index)) : redirect(url(:reset_password_tokens, :edit, :id => @reset_password_token.id))
    else
      @title = pat(:create_title, :model => 'reset_password_token')
      flash.now[:error] = pat(:create_error, :model => 'reset_password_token')
      render 'reset_password_tokens/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "reset_password_token #{params[:id]}")
    @reset_password_token = ResetPasswordToken.find(params[:id])
    if @reset_password_token
      render 'reset_password_tokens/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'reset_password_token', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "reset_password_token #{params[:id]}")
    @reset_password_token = ResetPasswordToken.find(params[:id])
    if @reset_password_token
      if @reset_password_token.update_attributes(params[:reset_password_token])
        flash[:success] = pat(:update_success, :model => 'Reset_password_token', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:reset_password_tokens, :index)) :
          redirect(url(:reset_password_tokens, :edit, :id => @reset_password_token.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'reset_password_token')
        render 'reset_password_tokens/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'reset_password_token', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Reset_password_tokens"
    reset_password_token = ResetPasswordToken.find(params[:id])
    if reset_password_token
      if reset_password_token.destroy
        flash[:success] = pat(:delete_success, :model => 'Reset_password_token', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'reset_password_token')
      end
      redirect url(:reset_password_tokens, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'reset_password_token', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Reset_password_tokens"
    unless params[:reset_password_token_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'reset_password_token')
      redirect(url(:reset_password_tokens, :index))
    end
    ids = params[:reset_password_token_ids].split(',').map(&:strip)
    reset_password_tokens = ResetPasswordToken.find(ids)
    
    if reset_password_tokens.each(&:destroy)
    
      flash[:success] = pat(:destroy_many_success, :model => 'Reset_password_tokens', :ids => "#{ids.to_sentence}")
    end
    redirect url(:reset_password_tokens, :index)
  end
end
