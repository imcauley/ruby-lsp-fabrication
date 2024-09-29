# frozen_string_literal: true

require 'ruby_lsp/addon'
require 'ruby_lsp/internal'

require_relative 'code_lens'

module RubyLsp
  module RSpec
    class Addon < ::RubyLsp::Addon
      def activate(global_state, message_queue)
        p 'I am right here'
      end

      def deactivate; end

      # Creates a new CodeLens listener. This method is invoked on every CodeLens request
      # def create_code_lens_listener(response_builder, uri, dispatcher)
      #   # return unless uri.to_standardized_path&.end_with?("_test.rb")

      #   CodeLens.new(response_builder, uri, dispatcher)
      # end

      def name
        'Ruby LSP Fabrication'
      end
    end
  end
end
