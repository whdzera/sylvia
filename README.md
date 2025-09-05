## Sylvia

![Lang](https://img.shields.io/badge/language-ruby-red)
[![Gem Version](https://img.shields.io/gem/v/sylvia.svg)](https://rubygems.org/gems/sylvia)
[![Gem Downloads](https://img.shields.io/gem/dt/sylvia.svg)](https://rubygems.org/gems/sylvia)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

My Private Assistant Tool for ruby development

## Installation

```
gem install sylvia
```

## Usage

##### Setup Prettier for ruby

```
sylvia prettier
```

##### Setup Rubocop

```
sylvia rubocop
```

##### Setup and Configuration AI LLM

```
sylvia llm
```

automatically created `sylvia.rb` and added configuration ruby_LLM (set your model LLM and API key)

ask to Ai like this

```ruby
chat.ask "how to improve this code", with: ["app/example.rb", "app/example2.rb"]
```

This is like a cursor/copilot, but manual.

##### Run AI LLM

```
sylvia ai
```

run ruby_LLM `sylvia.rb`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/whdzera/sylvia. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/whdzera/sylvia/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Sylvia project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/whdzera/sylvia/blob/master/CODE_OF_CONDUCT.md).
