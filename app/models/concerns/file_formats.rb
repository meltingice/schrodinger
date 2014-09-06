module FileFormats
  extend ActiveSupport::Concern

  included do
    # Right now we just use the first part of the mime-type, which
    # gives us a rough idea of the file type. Obviously, this is not
    # the best solution since this isn't too descriptive, e.g.
    # application/javascript makes a JS file sound like an app.
    def category
      return nil if filetype.nil?
      filetype.split('/').first
    end
  end
end
