class DropboxTreeService
  attr_reader :user, :root

  def initialize(user)
    @user = user
    @root = user.node_root
  end

  def update!
    ensure_root!
    build_structure(user.last_cursor)
  end

  private

  def ensure_root!
    @root ||= Node.create!({
      dropbox_id: user.id,
      name: '',
      dropbox_path: '',
      size: 0,
      filetype: nil
    })
  end

  def api
    @api ||= DropboxClient.new(user.access_token)
  end

  def build_structure(cursor = nil)
    # def delta(cursor=nil, path_prefix=nil)
    data = api.delta(cursor)
    data['entries'].each do |entry|
      entry[0].gsub!(/^(\/)/, '')
      path, metadata = entry

      if metadata.nil?
        remove_node(path)
      else
        process(path, metadata)
      end
    end

    if data['has_more']
      build_structure data['cursor']
    else
      user.update_attribute :last_cursor, data['cursor']
    end
  end

  def remove_node(path)
    @root.child_at_path(path).destroy
  end

  def process(path, metadata)
    existing_node = @root.child_at_path(path)
    if existing_node.present?
      return process_existing_node(existing_node, metadata)
    end

    parent = @root.mkdir_p(parent_path_for(path))

    Node.create!({
      dropbox_id: user.id,
      name: path_to_name(path),
      dropbox_path: path,
      size: metadata['bytes'],
      filetype: metadata['mime_type'],
      parent: parent
    })
  end

  def process_existing_node(node, metadata)
    node.update_attributes({
      size: metadata['size'],
      filetype: metadata['filetype']
    })
  end

  def path_to_name(path)
    path.split('/').last
  end

  def parent_path_for(item)
    item.split('/')[0...-1].join('/')
  end
end
