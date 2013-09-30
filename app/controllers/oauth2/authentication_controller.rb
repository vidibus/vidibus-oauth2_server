class Oauth2::AuthenticationController < Oauth2Controller
  skip_before_filter :verify_authenticity_token

  around_filter :oauth2_error_handler

  before_filter :validate_oauth2_type!
  before_filter :validate_oauth2_client_id!
  before_filter :validate_oauth2_redirect_url!

  before_filter :authenticate_user!, :only => :authorize
  before_filter :validate_oauth2_client_secret!, :only => :access_token

  def authorize
    args = params.slice(:client_id, :redirect_url)
    args[:user_id] = current_user.uuid
    token = Oauth2Token.create!(args)
    uri_params = {:code => token.code}
    uri_params[:state] = params[:state] if params.has_key?(:state)
    uri = params[:redirect_url].with_params(uri_params)
    redirect_to(uri)
  end

  def access_token
    token = Oauth2Token.find!(params)
    render({
      :text => {:access_token => token.token}.to_uri,
      :content_type => 'application/x-www-form-urlencoded',
      :status => :ok
    })
  end

  protected

  # Ensures that the type of flow is supported
  def validate_oauth2_type!
    type = params[:type] || params[:response_type] || params[:grant_type]
    raise Vidibus::Oauth2Server::MissingTypeError if type.blank?
    raise Vidibus::Oauth2Server::UnsupportedTypeError unless Vidibus::Oauth2Server::FLOWS.include?(type)
  end

  # Ensures that given client id is valid
  def validate_oauth2_client_id!
    raise Vidibus::Oauth2Server::MissingClientIdError if params[:client_id].blank?
    @oauth2_client = oauth2_client(params[:client_id])
    raise Vidibus::Oauth2Server::InvalidClientIdError unless @oauth2_client
  end

  # Ensures that redirect_url is valid for given client.
  def validate_oauth2_redirect_url!
    redirect_url = params[:redirect_url]
    raise Vidibus::Oauth2Server::MissingRedirectUrlError if redirect_url.blank?
    raise Vidibus::Oauth2Server::MalformedRedirectUrlError unless valid_uri?(redirect_url)
    unless redirect_url.match(/^https?:\/\/([a-z0-9]+\.)?#{@oauth2_client.domain}/) # allow subdomains but ensure host of client application
      raise Vidibus::Oauth2Server::InvalidRedirectUrlError
    end
  end

  # Ensures that given client_secret is valid for given client.
  def validate_oauth2_client_secret!
    raise Vidibus::Oauth2Server::InvalidClientSecretError unless @oauth2_client.valid_oauth2_secret?(params[:client_secret])
  end

  # Returns error message for given exception.
  def oauth2_error_handler
    begin
      yield
    rescue Vidibus::Oauth2Server::MissingTypeError
      error = 'missing_type'
    rescue Vidibus::Oauth2Server::UnsupportedTypeError
      error = 'unsupported_type'
    rescue Vidibus::Oauth2Server::MissingClientIdError
      error = 'missing_client_id'
    rescue Vidibus::Oauth2Server::InvalidClientIdError
      error = 'invalid_client_id'
    rescue Vidibus::Oauth2Server::InvalidClientSecretError
      error = 'invalid_client_secret'
    rescue Vidibus::Oauth2Server::MissingRedirectUrlError
      error = 'missing_redirect_url'
    rescue Vidibus::Oauth2Server::MalformedRedirectUrlError
      error = 'malformed_redirect_url'
    rescue Vidibus::Oauth2Server::InvalidRedirectUrlError
      error = 'invalid_redirect_url'
    rescue Vidibus::Oauth2Server::MissingCodeError
      error = 'missing_code'
    rescue Vidibus::Oauth2Server::InvalidCodeError
      error = 'invalid_code'
    rescue Vidibus::Oauth2Server::ExpiredCodeError
      error = 'expired_code'
    rescue Vidibus::Oauth2Server::InvalidTokenError
      error = 'invalid_token'
    rescue Vidibus::Oauth2Server::ExpiredTokenError
      error = 'expired_token'
    ensure
      if error
        status ||= :bad_request
        render :text => I18n.t("oauth2_server.errors.#{error}"), :status => status
      end
    end

    # Autorization error?
    # :status => :unauthorized # The response MUST include a WWW-Authenticate header field (section 14.47) containing a challenge applicable to the requested resource.
    # :status => :forbidden # Maybe better?
  end
end
