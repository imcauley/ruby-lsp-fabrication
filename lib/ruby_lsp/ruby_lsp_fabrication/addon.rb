# frozen_string_literal: true

require 'ruby_lsp/addon'
require 'ruby_lsp/internal'

require_relative 'document_symbol'

module RubyLsp
  module RSpec
    class Addon < ::RubyLsp::Addon
      def activate(global_state, message_queue); end

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
