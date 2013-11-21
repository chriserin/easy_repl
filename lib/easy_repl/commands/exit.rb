module EasyRepl
  module Commands
    class Exit
      extend Matchable

      def self.cmd_txt
        "exit"
      end

      def self.run
        throw :exit_repl, :exit
      end
    end
  end
end
