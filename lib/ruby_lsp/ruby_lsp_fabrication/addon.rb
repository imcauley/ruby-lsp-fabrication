# frozen_string_literal: true

require 'ruby_lsp/addon'
require 'ruby_lsp/internal'

require_relative 'document_symbol'
require_relative 'indexing_enhancement'
require_relative 'definition'

module RubyLsp
  module Fabrication
    class Addon < ::RubyLsp::Addon
      def activate(global_state, _message_queue)
        @index = global_state.index
        @index.register_enhancement(IndexingEnhancement.new)
      end

      def deactivate; end

      def create_definition_listener(response_builder, uri, node_context, dispatcher)
        Definition.new(response_builder, uri, node_context, @index, dispatcher)
      end

      def create_document_symbol_listener(response_builder, dispatcher)
        DocumentSymbol.new(response_builder, dispatcher)
      end

      def name
        'Ruby LSP Fabrication'
      end

      def version
        VERSION
      end
    end
  end
end
