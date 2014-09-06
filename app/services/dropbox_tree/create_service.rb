module DropboxTree
  class CreateService < Base
    attr_reader :user, :root

    def initialize(user)
      @user = user
      @root = nil
    end

    def fetch!
      build_structure @root, '/'
    end

    private

    def build_structure(parent, path)
      # def metadata(path, file_limit=25000, list=true, hash=nil, rev=nil, include_deleted=false)
      data = api.metadata(path, FILE_LIMIT, true, parent.try(:dropbox_hash))
      node = Node.create!({
        dropbox_id: user.id,
        dropbox_hash: data['hash'],
        name: path_to_name(data['path']),
        size: data['bytes'],
        filetype: nil,
        parent: parent
      })

      @root = node if parent.nil?
      
      data['contents'].each do |item|
        if item['is_dir']
          build_structure node, item['path']
        else
          Node.create!({
            dropbox_id: user.id,
            name: path_to_name(item['path']),
            size: item['bytes'],
            filetype: item['mime_type'],
            parent: node
          })
        end
      end
    end

    def path_to_name(path)
      path.split('/').pop
    end
  end
end
