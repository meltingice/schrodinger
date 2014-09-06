class NodePresenter < BasePresenter
  presents :node

  def files_count
    node.descendants.files.count
  end

  def total_space
    h.number_to_human_size node.deep_size
  end

  def each_path_component(&block)
    node.dropbox_path.split('/').each(&block)
  end

  def quota_percentage
    h.number_to_percentage (node.deep_size / current_user.account['quota']['quota'].to_f * 100), precision: 2
  end
end
