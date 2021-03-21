class AuthenticationsController < ApplicationController
  skip_before_action :authorize!

  def new
  end

  def create
    user = User.find_by(email: authentication_params[:email])
    puts "===================== CREATE"
    puts authentication_params
    if user && user.authenticate(authentication_params[:password])
      token = JwtAuthenticationService.encode_token({ user_id: user.id })
      user.loggedin = true
      render json: {user: user}
    else
      render json: { error: 'Invalid email or password' }, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

  private

  def authentication_params
    puts "===================== auth_private"
    puts params
    params.require(:authentication).permit(:email, :password)
  end
end
