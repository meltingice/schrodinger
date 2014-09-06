module DropboxTree
  class Base
    FILE_LIMIT = 25_000
    
    def api
      @api ||= DropboxClient.new(user.access_token)
    end
  end
end
