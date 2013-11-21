module EasyRepl
  module Commands
    class Reload
      extend Matchable

      def self.cmd_txt
        "reload"
      end

      def self.run
        throw :exit_repl, :reload
      end
    end
  end
end
