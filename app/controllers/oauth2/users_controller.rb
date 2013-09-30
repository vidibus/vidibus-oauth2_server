class Oauth2::UsersController < Oauth2Controller
  before_filter :ensure_token!
  before_filter :ensure_user

  def show
    attributes = user.try!(:oauth_attributes) || user.attributes.only(*%w[name email uuid])
    render :json => attributes
  end

  protected

  def user
    @user ||= User.where(:uuid => @access_token.user_id).first
  end

  def ensure_user
    unless user
      render(:nothing => true, :status => :bad_request)
    end
  end

  def ensure_token!
    if header = request.headers['Authorization']
      token = header[/Bearer (.+)/, 1]
    end
    token ||= params[:access_token] || params[:oauth_token]
    unless token
      raise Vidibus::Oauth2Server::MissingTokenError
    end
    @access_token = Oauth2Token.find!(:token => token)
  end
end
