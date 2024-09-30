# frozen_string_literal: true

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
          @response_builder.last.children << RubyLsp::Interface::DocumentSymbol.new(
            name: generate_fabricator_name(node),
            kind: LanguageServer::Protocol::Constant::SymbolKind::CLASS,
            selection_range: range_from_node(node),
            range: range_from_node(node)
          )
        when 'Fabricate'
          @response_builder.last.children << RubyLsp::Interface::DocumentSymbol.new(
            name: generate_fabricate_name(node),
            kind: LanguageServer::Protocol::Constant::SymbolKind::OBJECT,
            selection_range: range_from_node(node),
            range: range_from_node(node)
          )
        end
      end

      def on_call_node_leave(node); end

      def generate_fabricator_name(node)
        arguments = node.compact_child_nodes.first
        name = arguments.compact_child_nodes.first.value

        "#{name.titleize} Fabricator"
      end

      def generate_fabricate_name(node)
        arguments = node.compact_child_nodes.first
        name = arguments.compact_child_nodes.first.value

        "Fabricated #{name.titleize}"
      end
    end
  end
end
