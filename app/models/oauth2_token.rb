require "active_support"

class Oauth2Token
  include Mongoid::Document
  include Mongoid::Timestamps

  CODE_EXPIRY = 60 # Lifetime of token authorization code in seconds.
  TOKEN_EXPIRY = 0 # Lifetime of token in seconds. 0 will never expire token.

  field :client_id
  field :user_id
  field :redirect_url
  field :token
  field :secret
  field :code

  field :code_expires_at, :type => Time
  field :token_expires_at, :type => Time

  index :client_id
  index :token
  index :code

  validates :client_id, :redirect_url, :presence => true
  validates :token, :code, :uniqueness => { :allow_blank => true }

  before_create :generate_code

  # Returns a token by given parameters.
  # If +token+ is given a valid Oauth2Token will be returned.
  # If +client_id+ and +redirect_url+ is given the +code+ provided will be exchanged for a token.
  def self.find!(args = {})
    if tok = args[:token]
      token = Oauth2Token.where(:token => tok).first
      raise Vidibus::Oauth2Server::InvalidTokenError unless token
      raise Vidibus::Oauth2Server::ExpiredTokenError if token.token_expires_at and token.token_expires_at < Time.now
    else
      client_id = args[:client_id]
      redirect_url = args[:redirect_url]
      code = args[:code]

      raise Vidibus::Oauth2Server::MissingClientIdError if client_id.blank?
      raise Vidibus::Oauth2Server::MissingRedirectUrlError if redirect_url.blank?
      raise Vidibus::Oauth2Server::MissingCodeError if code.blank?

      token = Oauth2Token.where(:client_id => client_id).and(:code => code).first
      raise Vidibus::Oauth2Server::InvalidCodeError unless token
      raise Vidibus::Oauth2Server::InvalidRedirectUrlError unless redirect_url == token.redirect_url

      token.exchange!
    end
    token
  end

  # Exchanges the code for a token if given code is valid and has not expired yet.
  def exchange!
    raise Vidibus::Oauth2Server::InvalidCodeError unless code
    raise Vidibus::Oauth2Server::ExpiredCodeError unless code_expires_at >= Time.now
    self.code = nil
    self.code_expires_at = nil
    self.token = ActiveSupport::SecureRandom.hex(60)
    self.token_expires_at = Time.now + TOKEN_EXPIRY if TOKEN_EXPIRY > 0
    save!
    return code
  end

  protected

  # Generate a random code
  def generate_code
    self.code = ActiveSupport::SecureRandom.hex(60)
    self.code_expires_at = Time.now + CODE_EXPIRY
  end
end
