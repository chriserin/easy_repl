require 'irb/locale'
require 'irb/input-method'
require 'irb/ext/save-history'

module IRB
  def self.conf
    {
      LC_MESSAGES: Locale.new,
      SAVE_HISTORY: 100,
      HISTORY_FILE: '.easyrepl_history',
      AT_EXIT: []
    }
  end
end
IRB::HistorySavingAbility.extend(IRB::HistorySavingAbility)

module EasyRepl
  module Repl
    def start
      while(true) do
        setup
        exit_value = catch(:exit_repl) do
          loop do
            if block_given?
              yield
            else
              puts EasyRepl.gets
            end
          end
        end
        return if exit_value == :exit
      end
    ensure
      teardown
      IRB::HistorySavingAbility.save_history
    end

    def gets
      input = prompt.gets
      command = commands.find {|c| c.matches(input)}
      if command
        command.run
        return ""
      else
        return input
      end
    end

    private
    def commands
      @commands ||= [EasyRepl::Commands::Exit, EasyRepl::Commands::Reload]
    end

    def prompt
      @io ||= IRB::ReadlineInputMethod.new.tap do |new_io|
        new_io.prompt = "> "
      end
    end
  end
end
