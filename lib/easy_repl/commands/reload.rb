module EasyRepl
  module Commands
    class Reload
      extend Matchable

      def self.cmd_txt
        "reload"
      end

      def self.run(input)
        throw :exit_inner_loop, :reload
      end
    end
  end
end
