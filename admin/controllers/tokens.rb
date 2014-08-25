BemyeyesBackend::Admin.controllers :tokens do
  get :index do
    @title = "Tokens"
    @tokens = Token.all
    render 'tokens/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'token')
    @token = Token.new
    render 'tokens/new'
  end

  post :create do
    @token = Token.new(params[:token])
    if @token.save
      @title = pat(:create_title, :model => "token #{@token.id}")
      flash[:success] = pat(:create_success, :model => 'Token')
      params[:save_and_continue] ? redirect(url(:tokens, :index)) : redirect(url(:tokens, :edit, :id => @token.id))
    else
      @title = pat(:create_title, :model => 'token')
      flash.now[:error] = pat(:create_error, :model => 'token')
      render 'tokens/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "token #{params[:id]}")
    @token = Token.find(params[:id])
    if @token
      render 'tokens/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'token', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "token #{params[:id]}")
    @token = Token.find(params[:id])
    if @token
      if @token.update_attributes(params[:token])
        flash[:success] = pat(:update_success, :model => 'Token', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:tokens, :index)) :
          redirect(url(:tokens, :edit, :id => @token.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'token')
        render 'tokens/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'token', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Tokens"
    token = Token.find(params[:id])
    if token
      if token.destroy
        flash[:success] = pat(:delete_success, :model => 'Token', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'token')
      end
      redirect url(:tokens, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'token', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Tokens"
    unless params[:token_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'token')
      redirect(url(:tokens, :index))
    end
    ids = params[:token_ids].split(',').map(&:strip)
    tokens = Token.find(ids)
    
    if tokens.each(&:destroy)
    
      flash[:success] = pat(:destroy_many_success, :model => 'Tokens', :ids => "#{ids.to_sentence}")
    end
    redirect url(:tokens, :index)
  end
end
