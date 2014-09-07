class NodeSerializer < NodeNoAssociationSerializer
  attributes :category_stats

  # has_many :files,    serializer: NodeNoAssociationSerializer
  # has_many :folders,  serializer: NodeNoAssociationSerializer

  def category_stats
    object.deep_categories_with_size
  end

  def files
    object.children.files
  end

  def folders
    object.children.folders
  end
end
