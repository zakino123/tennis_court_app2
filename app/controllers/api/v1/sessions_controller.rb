class Api::V1::SessionsController < ApiController
  wrap_parameters :user, include: [:email, :password]

  def new
  end

  def create
    user = User.find_by(email: params[:user][:email])
    if !user.nil? && user.authenticate(params[:user][:password])
      # log_in user
      # params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      # redirect_back_or user
      render json: user
    else
      # flash.now[:danger] = 'メールアドレスかパスワードが間違っています。'
      # render 'new'
      # render status: :internal_server_error
      render json: { message: 'ログイン出来ませんでした'}
    end
  end

  def destroy
    log_out if logged_in?
    # redirect_to root_url
    render json: { state: true }
  end
end
