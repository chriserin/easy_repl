module EasyRepl
  module Commands
    class Exit
      extend Matchable

      def self.cmd_txt
        "exit"
      end

      def self.run(input)
        throw :exit_inner_loop, :exit
      end
    end
  end
end
