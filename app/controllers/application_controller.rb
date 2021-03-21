class ApplicationController < ActionController::API
  before_action :authorize!

  private

  def current_user()
    # user_id = JwtAuthenticationService.decode_token(request)
    @user = User.find_by(email: params[:email])
    puts "=============current_user==========#{params}"
    if @user && @user.authenticate(params[:password])
      @user.update_attribute('loggedin',true)
      return @user.loggedin
    else
      render json: { error: 'Invalid email or password' }, status: :unprocessable_entity
    end
  end

  def logged_in?
    !!current_user
  end

  def authorize!
    p'********************************'
    p current_user()
    p'********************************'

    
    return true if current_user()

    render json: { message: 'Please log in' }, status: :unauthorized
  end

  def render_jsonapi_internal_server_error(exception)
    puts(exception)
    super(exception)
  end
end
