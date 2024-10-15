# frozen_string_literal: true

require 'ruby_lsp/addon'
require 'ruby_lsp/internal'

require_relative 'document_symbol'
require_relative 'indexing_enhancement'

module RubyLsp
  module Fabrication
    class Addon < ::RubyLsp::Addon
      def activate(global_state, message_queue)
        @global_state = global_state
        @index = global_state.index
        global_state.index.register_enhancement(IndexingEnhancement.new)
      end

      def deactivate; end

      def create_document_symbol_listener(response_builder, dispatcher)
        DocumentSymbol.new(response_builder, dispatcher)
      end

      def name
        'Ruby LSP Fabrication'
      end
    end
  end
end
