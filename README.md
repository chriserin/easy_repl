# EasyRepl

A Repl (Read Eval Print Loop) library.

## Features

  * Ease of use.  Just pass a block to the start method to process the user's input.
  * Command History
  * Exit Command
  * Reload Command
  * Setup and Teardown lifecycle methods
  * After Input and Before Input lifecylce methods

## Usage

```ruby
  require 'easy_repl'

  #start an echoing repl
  EasyRepl.start

  # > a
  # a
  # > b
  # b
  # > exit

  #start a repl that reverses input
  EasyRepl.start do |input|
    puts input.reverse
  end

  # > abc
  # cba
  # > def
  # fed
  # > exit

  #create a repl class with a life cycle
  class MyRepl
    include EasyRepl::Repl

    def setup
      puts "LOADING RESOURCES"
    end

    def before_input
      puts "before_input"
    end

    def process_input(input)
      puts input.reverse
    end

    def after_input
      puts "after_input"
    end

    def teardown
      puts "CLOSING RESOURCES"
    end

  end

  MyRepl.new.start

  # LOADING RESOURCES
  # before_input
  # > abc
  # after_input
  # cba
  # before_input
  # > reload
  # after_input
  # CLOSING RESOURCES
  # LOADING RESOURCES
  # before_input
  # > exit
  # after_input
  # CLOSING RESOURCES


  # rename the history file before starting the repl
  EasyRepl.history_file = ".myrepl_history"
  EasyRepl.start
```

## Installation

Add this line to your application's Gemfile:

    gem 'easy_repl'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install easy_repl


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
