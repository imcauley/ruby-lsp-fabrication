# frozen_string_literal: true

module RubyLsp
  module Fabrication
    class IndexingEnhancement
      include RubyIndexer::Enhancement

      def on_call_node(index, owner, node, file_path, code_units_cache)
        return unless owner

        name = node.message

        p 'A' if name == 'Fabricate'
        p 'B' if name == 'Fabricator'
      end
    end
  end
end
