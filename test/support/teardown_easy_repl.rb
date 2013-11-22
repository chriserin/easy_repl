require './lib/easy_repl'

module Support
  class TeardownEasyRepl
    extend EasyRepl::Repl

    def self.teardown
      puts "TEARDOWN"
    end
  end
end
