module Support
  class CommandSequence
    def initialize(*args)
      @commands = args
    end

    def gets
      @commands.shift
    end
  end
end
