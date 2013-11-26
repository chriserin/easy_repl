require './lib/easy_repl'

module Support
  class BeforeInputEasyRepl
    extend EasyRepl::Repl

    def self.before_input
      puts "BEFOREINPUT"
    end
  end
end

