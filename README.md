# Carnival

Easily mask your mailto-links with Carnival. Make the spambots' lifes hard by hiding your real address.

Inspired by http://www.jottings.com/obfuscator/

## Installation

Add this line to your application's Gemfile:

    gem 'carnival'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install carnival

## Usage

Use Carnival in your views like this:

    carnival 'my_mail@example.com'

This will create an obfuscated mailto-link with the address as the link text. If you want a custom link text, pass
it as a second parameter:

    carnival 'my_mail@example.com', 'Contact us!

The decoder relies on JavaScript to work. If your users have JS disabled, a hint will be shown that they need to enable JS in order to view the address.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
