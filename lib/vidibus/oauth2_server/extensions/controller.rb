module Vidibus
  module Oauth2Server
    module Extensions

      # Contains core modifications of rails controller methods.
      module Controller

        # Authenticates user.
        def authenticate_user!
          raise "Add a method #authenticate_user! to your ApplicationController that authenticates the user."
        end

        # Returns user with matching uuid.
        def find_user_by_uuid(uuid)
          raise "Add a method #find_user_by_uuid to your ApplicationController to return a user with matching uuid."
        end

        # Returns Oauth2 client application matching given id.
        def oauth2_client(id)
          raise "Add a method #oauth2_client to your ApplicationController that returns the OAuth client application for given id."
        end
      end
    end
  end
end
