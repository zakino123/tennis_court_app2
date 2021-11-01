class Api::V1::SessionsController < ApiController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      # log_in user
      # params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      # redirect_back_or user
      render json: user
    else
      # flash.now[:danger] = 'メールアドレスかパスワードが間違っています。'
      # render 'new'
      render status: :internal_server_error
    end
  end

  def destroy
    log_out if logged_in?
    # redirect_to root_url
    render json: { state: true }
  end
end
