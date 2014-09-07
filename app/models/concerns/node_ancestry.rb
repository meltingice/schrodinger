module NodeAncestry
  extend ActiveSupport::Concern

  included do
    def folders
      children.folders
    end

    def files
      children.files
    end

    def child_at_path(path)
      descendants.where(dropbox_path: path).first
    end
    alias_method :child_with_path, :child_at_path

    def child_with_name(name)
      children.where(name: name).first
    end

    def mkdir_p(path)
      return self if path.blank?
      
      child_name = path.split('/').first
      node = child_with_name(child_name)

      if node.nil?
        node = Node.create!({
          dropbox_id: dropbox_id,
          name: child_name,
          dropbox_path: File.join(dropbox_path, child_name).gsub(/^(\/)/, ''),
          size: 0,
          filetype: nil,
          parent: self
        })
      end

      node.mkdir_p(path.split('/')[1..-1].join('/'))
    end
  end
end
