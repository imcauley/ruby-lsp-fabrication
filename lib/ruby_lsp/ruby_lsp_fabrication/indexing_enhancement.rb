# frozen_string_literal: true

module RubyLsp
  module Fabrication
    class IndexingEnhancement
      include RubyIndexer::Enhancement

      def on_call_node(index, owner, node, file_path, code_units_cache)
        name = node.message

        return unless name == 'Fabricator'

        index.add(RubyIndexer::Entry::Method.new(
                    generate_fabricator_name(node),
                    file_path,
                    RubyIndexer::Location.from_prism_location(node.location, code_units_cache),
                    RubyIndexer::Location.from_prism_location(node.location, code_units_cache),
                    nil,
                    [RubyIndexer::Entry::Signature.new([])],
                    RubyIndexer::Entry::Visibility::PUBLIC,
                    owner
                  ))
      end

      def generate_fabricator_name(node)
        arguments = node.compact_child_nodes.first
        name = arguments.compact_child_nodes.first.value

        "#{name}Fabricator"
      end
    end
  end
end
