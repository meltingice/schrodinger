class NodeSerializer < BaseSerializer
  attributes :name, :path, :size, :filetype, :category_stats

  def path
    object.dropbox_path
  end

  def category_stats
    object.deep_categories_with_size
  end
end
