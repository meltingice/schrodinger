class NodeNoAssociationSerializer < BaseSerializer
  attributes :name, :path, :size, :deep_size, :filetype

  def path
    object.dropbox_path
  end
end
