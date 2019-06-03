[![CircleCI](https://circleci.com/gh/iarie/pwush/tree/master.svg?style=shield)](https://circleci.com/gh/iarie/pwush/tree/master)
[![Gem Version](https://badge.fury.io/rb/pwush.svg)](https://badge.fury.io/rb/pwush)
[![Maintainability](https://api.codeclimate.com/v1/badges/d1887381dee84e26e860/maintainability)](https://codeclimate.com/github/iarie/pwush/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/d1887381dee84e26e860/test_coverage)](https://codeclimate.com/github/iarie/pwush/test_coverage)

# Pwush

Pwush is a remote api toolkit for [Pushwoosh](https://www.pushwoosh.com/v1.0/reference)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pwush', '~> 0.3.0'
```

And then execute:

	$ bundle

Or install it yourself as:

	$ gem install pwush

## Basic Usage

### Setup pwush client
```ruby
MyPW = Pwush.new(auth: 'AUTH_KEY', app: 'APP_CODE', timeout: { connect: 5, read: 10, write: 2 })
```
### Push message
```ruby
MyPW.create_message(content: 'Hello, there!')
```
### Using built-in struct
```ruby
first_message = Pwush::Message.new(
  content: { en: 'Hello' },
  send_date: '2018-04-06 23:00',
  timezone: 'Europe/London',
  devices: ['token1', 'token2'],
  ios_title: 'This is the test message',
  ios_subtitle: 'subtitle!'
)

second_message = Pwush::Message.new(
  content: { es: 'Hola' },
  send_date: '2018-04-06 23:00',
  timezone: 'Europe/Madrid',
  devices: ['token3', 'token4'],
  android_banner: 'This is the test message',
  android_gcm_ttl: 3600
)

MyPW.push(first_message, second_message)
```

### Result
The result is `dry-monads` Success or Failure, [read about it](http://dry-rb.org/gems/dry-monads/result/)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/iarie/pwush. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PwRb project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/iarie/pwush/blob/master/CODE_OF_CONDUCT.md).
