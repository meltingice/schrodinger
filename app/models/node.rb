class Node < ActiveRecord::Base
  has_ancestry touch: true

  include FileFormats

  scope :files, -> { where('filetype IS NOT NULL') }
  scope :folders, -> { where(filetype: nil) }

  def file_ext
    Pathname.new(name).extname[1..-1]
  end

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

  def file?
    filetype.present?
  end

  def folder?
    filetype.nil?
  end

  def deep_size
    return size if file?

    Rails.cache.fetch [id, updated_at] do
      descendants.files.pluck(:size).inject(0) { |sum, size| sum + size }
    end
  end

  def categories_with_size(nodes = files)
    categories = {}
    nodes.each do |node|
      next if node.category.nil?

      categories[node.category] = 0 unless categories.has_key?(node.category)
      categories[node.category] += node.size
    end

    categories
  end

  def deep_categories_with_size
    categories_with_size(descendants)
  end
end
