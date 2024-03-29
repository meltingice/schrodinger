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

  # Builds the node tree based on the API delta response.
  # If the delta response is paginated, it will recursively
  # call build_structure until all delta entries are processed.
  def build_structure(cursor = nil)
    # def delta(cursor=nil, path_prefix=nil)
    data = api.delta(cursor)

    reset_account! if data['reset']

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
      user.update_attribute :last_cursor, data['cursor']
      build_structure data['cursor']
    else
      user.update_attributes({
        last_checked_at: Time.now,
        last_cursor: data['cursor'],
        account_ready: true
      })
    end
  end

  # If true, clear your local state before processing the delta entries.
  # reset is always true on the initial call to /delta (i.e. when no cursor is passed in).
  # Otherwise, it is true in rare situations, such as after server or account maintenance, 
  # or if a user deletes their app folder.
  def reset_account!
    @root.children.each(&:destroy)
  end

  # [<path>, null] - Indicates that there is no file/folder at the given path.
  # To update your local state to match, anything at path and all its children 
  # should be deleted. Deleting a folder in your Dropbox will sometimes send down 
  # a single deleted entry for that folder, and sometimes separate entries for the 
  # folder and all child paths. If your local state doesn't have anything at path, 
  # ignore this entry.
  def remove_node(path)
    node = @root.child_at_path(path)
    node.destroy if node.present?
  end

  # Delta response has metadata
  def process(path, metadata)
    existing_node = @root.child_at_path(path)
    if existing_node.present?
      return process_existing_node(existing_node, metadata)
    end

    # If the new entry includes parent folders that don't yet exist in your local state, 
    # create those parent folders in your local state.
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

  # We determine file/folder based on the filetype returned with the metadata. If it's
  # nil, then we know it's a folder. No need to check what time already exists, just
  # overwrite it.
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
