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
      loop do #outer loop
        setup if respond_to? :setup
        begin
          exit_inner_loop_value = catch(:exit_inner_loop) do
            loop do #inner loop
              begin
                catch(:skip_process_input) do
                  before_input if respond_to? :before_input
                  if block_given?
                    yield self.gets
                  elsif respond_to? :process_input
                    process_input(self.gets)
                  else
                    puts self.gets
                  end
                end
              ensure
                after_input if respond_to? :after_input
              end
            end
          end
          return if exit_inner_loop_value == :exit
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
        return command.run(input)
      else
        return input
      end
    end

    def commands
      @commands ||= [EasyRepl::Commands::Exit, EasyRepl::Commands::Reload]
    end

    private
    def prompt
      @io ||= IRB::ReadlineInputMethod.new.tap do |new_io|
        new_io.prompt = "> "
      end
    end
  end
end
