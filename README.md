# CssClassDuplicates

CssClassDuplicates is a Ruby tool that helps to refactor code by scanning the project for CSS class duplicates. It's useful for utility CSS frameworks like [Tailwind CSS](https://tailwindcss.com/). 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'css_class_duplicates', require: false
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install css_class_duplicates

## Usage

Running css_class_duplicates checks all files in the current folder using default configuration:

    $  css_class_duplicates

Configuration can be overridden using a `.css_class_duplicates.yml` file in the current folder 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/a-kushnir/css_class_duplicates. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
