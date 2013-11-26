require './lib/easy_repl'

module Support
  class AfterInputEasyRepl
    extend EasyRepl::Repl

    def self.after_input
      puts "AFTERINPUT"
    end
  end
end
