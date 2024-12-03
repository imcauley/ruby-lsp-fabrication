# frozen_string_literal: true

class Utils
  def self.get_name_from_fabricator(node)
    arguments = node.compact_child_nodes.first
    return nil unless arguments

    name_node = arguments.compact_child_nodes.first
    return nil unless name_node

    "#{name.titleize} Fabricator"
  end

  def self.get_name_from_fabricate(node)
    arguments = node.compact_child_nodes.first
    return nil unless arguments

    name_node = arguments.compact_child_nodes.first
    return nil unless name_node

    "Fabricated #{name_node.value.titleize}"
  end
end
