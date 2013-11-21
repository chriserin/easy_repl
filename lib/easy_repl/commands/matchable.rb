module EasyRepl
  module Commands
    module Matchable
      def matches(input)
        input =~ /^#{cmd_txt}/
      end
    end
  end
end
