class NodePresenter < BasePresenter
  presents :node

  def files_count
    node.descendants.files.count
  end

  def total_space
    h.number_to_human_size node.deep_size
  end
end
