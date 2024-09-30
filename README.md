# Ruby LSP Fabrication

[![Gem Version](https://badge.fury.io/rb/ruby-lsp-fabrication.svg)](https://badge.fury.io/rb/ruby-lsp-fabrication)

Ruby LSP Fabrication is a [Ruby LSP](https://github.com/Shopify/ruby-lsp) addon for displaying and linking [Fabricators](https://fabricationgem.org/)

## Installation

To install, add the following line to your application's Gemfile:

```ruby
# Gemfile
group :development do
  gem "ruby-lsp-fabrication", require: false
end
```

After running `bundle install`, restart Ruby LSP and you should start seeing Document Symbols.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/imcauley/ruby-lsp-fabrication. See Code of Conduct

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
