require 'irb/locale'
require 'irb/input-method'
require 'irb/ext/save-history'

module IRB
  def self.conf
    {
      LC_MESSAGES: Locale.new,
      SAVE_HISTORY: 100,
      HISTORY_FILE: EasyRepl.history_file || '.easyrepl_history',
      AT_EXIT: []
    }
  end
end

module EasyRepl
  module Repl
    def start
      IRB::HistorySavingAbility.extend(IRB::HistorySavingAbility) unless IRB::HistorySavingAbility === IRB::HistorySavingAbility
      loop do
        setup if respond_to? :setup
        begin
          exit_value = catch(:exit_repl) do
            loop do
              begin
                before_input if respond_to? :before_input
                if block_given?
                  yield EasyRepl.gets
                elsif respond_to? :process_input
                  process_input(EasyRepl.gets)
                else
                  puts EasyRepl.gets
                end
              ensure
                after_input if respond_to? :after_input
              end
            end
          end
          return if exit_value == :exit
        ensure
          teardown if respond_to? :teardown
        end
      end
    ensure
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
