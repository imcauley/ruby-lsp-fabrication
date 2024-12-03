# frozen_string_literal: true

require_relative 'utils'

module RubyLsp
  module Fabrication
    class DocumentSymbol
      include ::RubyLsp::Requests::Support::Common

      def initialize(response_builder, dispatcher)
        @response_builder = response_builder

        dispatcher.register(self, :on_call_node_enter, :on_call_node_leave)
      end

      def on_call_node_enter(node)
        case node.message
        when 'Fabricator'
          name = Utils.get_name_from_fabricator(node)
          return unless name

          @response_builder.last.children << RubyLsp::Interface::DocumentSymbol.new(
            name: name,
            kind: LanguageServer::Protocol::Constant::SymbolKind::CLASS,
            selection_range: range_from_node(node),
            range: range_from_node(node)
          )
        when 'Fabricate'
          name = Utils.get_name_from_fabricate(node)
          return unless name

          @response_builder.last.children << RubyLsp::Interface::DocumentSymbol.new(
            name: name,
            kind: LanguageServer::Protocol::Constant::SymbolKind::OBJECT,
            selection_range: range_from_node(node),
            range: range_from_node(node)
          )
        end
      end

      def on_call_node_leave(node); end
    end
  end
end
