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

## Configuration

Configuration can be overridden using a `.css_class_duplicates.yml` file in the current folder. See default configuration [here](https://github.com/a-kushnir/css_class_duplicates/blob/main/config/default.yml).

### Files

Use include/exclude keys do describe paths to scan. Wildcards are supported:

```yaml
files:
  include:
    - "app/views/**/*.html.erb"
    - "engines/*/app/views/**/*.html.erb"
  exclude:
    - "app/views/layouts/**"
```

### Matches

Describes matching type which can be either exact or partial:

```yaml
matches:
  type: 'exact'
```

In case exact match is selected matches such as "form block left" and "form block center" are considered different ones. If partial match is selected, the tool gathers information about "form block left" (1 match), "form block center" (1 match), and "form block" (2 matches).

### Filters

Use filters configuration to filter unnecessary data out. The example below allows "form block" (3 matches) to be displayed and "form" (5 matches) or "form hidden" (1 match) to be ignored: 

```yaml
filters:
  classes:
    min: 2
  matches:
    min: 3
```

The tool can search for or ignore classes specified in the configuration. Wildcards are supported:

```yaml
filters:
  classes:
    include:
      - '*'               # Include the match only if it contains the class
    exclude:
      - 'first:*'         # Exclude the match if it contains the class
      - 'btn btn-primary' # Exclude the match if it contains the classes
    delete:
      - 'hidden'          # Deletes the class from match
```

The example above excludes all classes which start with "first:" or have "btn btn-primary" combination of classes. The following matches "form block hidden" and "form block" are considered the same because "hidden" class is deleted from the list of classes. 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/a-kushnir/css_class_duplicates. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
