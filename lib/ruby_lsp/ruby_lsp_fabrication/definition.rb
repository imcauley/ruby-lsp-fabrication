# frozen_string_literal: true

module RubyLsp
  module Fabrication
    class Definition
      include ::RubyLsp::Requests::Support::Common

      def initialize(response_builder, uri, node_context, index, dispatcher)
        @response_builder = response_builder
        @uri = uri
        @node_context = node_context
        @index = index
        dispatcher.register(self, :on_symbol_node_enter)
      end

      def on_symbol_node_enter(node)
        if @node_context.call_node.message == 'Fabricator' && inherited?(node)
          entries = @index["#{node.value}Fabricator"]

          return if entries.blank? || entries.empty?

          entries.each do |entry|
            @response_builder << Interface::LocationLink.new(
              target_uri: URI::Generic.from_path(path: entry.file_path).to_s,
              target_range: range_from_location(entry.location),
              target_selection_range: range_from_location(entry.name_location)
            )
          end

          return
        end

        return unless @node_context.call_node.message == 'Fabricate'

        fabricator_name = generate_fabricator_name(@node_context.call_node)
        entries = @index[fabricator_name]
        return if entries.blank? || entries.empty?

        entries.each do |entry|
          @response_builder << Interface::LocationLink.new(
            target_uri: URI::Generic.from_path(path: entry.file_path).to_s,
            target_range: range_from_location(entry.location),
            target_selection_range: range_from_location(entry.name_location)
          )
        end
      end

      def inherited?(node)
        @node_context.parent.compact_child_nodes.first.compact_child_nodes.each do |n|
          next unless n.type == :keyword_hash_node

          first_child = n.compact_child_nodes.first
          next unless first_child.type == :assoc_node
          next unless first_child.key.value == 'from'
          next unless first_child.value.value == node.value

          return true
        end

        false
      end

      def generate_fabricator_name(node)
        arguments = node.compact_child_nodes.first
        name = arguments.compact_child_nodes.first.value

        "#{name}Fabricator"
      end
    end
  end
end
