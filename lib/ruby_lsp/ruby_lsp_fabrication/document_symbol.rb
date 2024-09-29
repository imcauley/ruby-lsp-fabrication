# frozen_string_literal: true

module RubyLsp
  module RSpec
    class DocumentSymbol
      include ::RubyLsp::Requests::Support::Common

      def initialize(response_builder, dispatcher)
        @response_builder = response_builder

        dispatcher.register(self, :on_call_node_enter, :on_call_node_leave)
      end

      def on_call_node_enter(node)
        return unless node.message == 'Fabricator'

        @response_builder.last.children << RubyLsp::Interface::DocumentSymbol.new(
          name: generate_name(node),
          kind: LanguageServer::Protocol::Constant::SymbolKind::CLASS,
          selection_range: range_from_node(node),
          range: range_from_node(node)
        )
      end

      def on_call_node_leave(node)
        case node.message
        when 'context', 'describe'
          return if node.receiver && node.receiver&.slice != 'RSpec'

          @response_builder.pop
        end
      end

      def generate_name(node)
        arguments = node.compact_child_nodes.first
        name = arguments.compact_child_nodes.first.value

        "#{name.titleize} Fabricator"
      end
    end
  end
end
