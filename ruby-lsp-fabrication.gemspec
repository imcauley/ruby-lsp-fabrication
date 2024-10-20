# frozen_string_literal: true

require_relative 'lib/ruby_lsp_fabrication/version'

Gem::Specification.new do |s|
  s.name = 'ruby-lsp-fabrication'
  s.version = RubyLsp::Fabrication::VERSION
  s.email = ['mcauleyisaac@gmail.com']
  s.summary     = 'Ruby LSP Addon for Fabrication support'
  s.authors     = ['Isaac McAuley']
  s.license = 'MIT'
  s.homepage = 'https://github.com/imcauley/ruby-lsp-fabrication'
  s.required_ruby_version = '>= 3.0.0'

  s.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(
          'bin/',
          'test/',
          'spec/',
          'features/',
          '.git',
          '.circleci',
          'appveyor',
          'Gemfile',
          'misc/',
          'sorbet/'
        )
    end
  end
  s.require_paths = ['lib']

  s.add_dependency 'ruby-lsp', '~> 0.20.1'
end
