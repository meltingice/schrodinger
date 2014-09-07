class NodePresenter < BasePresenter
  presents :node

  def files_count
    h.number_with_delimiter node.descendants.files.count
  end

  def folders_count
    h.number_with_delimiter node.descendants.folders.count
  end

  def total_space
    @total_space ||= h.number_to_human_size node.deep_size
  end

  def percentage_space
    h.number_to_percentage (node.deep_size/ node.root.deep_size.to_f * 100), precision: 2
  end

  def each_path_component(&block)
    (node.ancestors + [node]).each(&block)
  end

  def quota_percentage
    h.number_to_percentage (node.deep_size / current_user.account['quota']['quota'].to_f * 100), precision: 2
  end

  def usage_width
    (node.deep_size / node.parent.deep_size.to_f) * 100
  end
end
