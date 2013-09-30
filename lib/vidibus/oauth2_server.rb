module Vidibus
  module Oauth2Server
    class Oauth2ServerError < StandardError; end

    class MissingTypeError < Oauth2ServerError; end
    class UnsupportedTypeError < Oauth2ServerError; end

    class MissingClientIdError < Oauth2ServerError; end
    class InvalidClientIdError < Oauth2ServerError; end
    class InvalidClientSecretError < Oauth2ServerError; end

    class MissingRedirectUrlError < Oauth2ServerError; end
    class MalformedRedirectUrlError < Oauth2ServerError; end
    class InvalidRedirectUrlError < Oauth2ServerError; end

    class MissingCodeError < Oauth2ServerError; end
    class InvalidCodeError < Oauth2ServerError; end
    class ExpiredCodeError < Oauth2ServerError; end

    class InvalidTokenError < Oauth2ServerError; end
    class ExpiredTokenError < Oauth2ServerError; end
    class MissingTokenError < Oauth2ServerError; end

    FLOWS = %w[web_server code authorization_code]
  end
end
