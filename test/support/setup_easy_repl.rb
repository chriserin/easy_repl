require './lib/easy_repl'

module Support
  class SetupEasyRepl
    extend EasyRepl::Repl

    def self.setup
      puts "SETUP"
    end
  end
end
