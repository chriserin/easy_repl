require './test/support'
require './lib/easy_repl'
require 'ostruct'

describe EasyRepl do
  it "starts and exits" do
    out = ''
    EasyRepl.stub :prompt, OpenStruct.new(:gets => "exit") do
      out, err = capture_io do
        EasyRepl.start
      end
    end
    assert_includes out, ""
  end

  it "easy repl accepts a block" do
    out = ''
    seq = Support::CommandSequence.new "XXX", "exit"
    EasyRepl.stub :prompt, seq do
      out, err = capture_io do
        EasyRepl.start do |input|
          puts input
        end
      end
    end
    assert_equal out, "XXX\n"
  end

  it "echos all inputs before exit" do
    out = ''
    seq = Support::CommandSequence.new "abc", "def", "ghi", "exit"
    EasyRepl.stub :prompt, seq do
      out, err = capture_io do
        EasyRepl.start
      end
    end
    assert_equal "abc\ndef\nghi\n", out
  end

  it "accepts a block that echos reversed input" do
    out = ''
    seq = Support::CommandSequence.new "abc", "def", "ghi", "exit"
    EasyRepl.stub :prompt, seq do
      out, err = capture_io do
        EasyRepl.start do |input|
          puts input.reverse
        end
      end
    end
    assert_equal "cba\nfed\nihg\n", out
  end

  describe "setup is defined" do
    it "calls setup before asking for input" do
      out = ''
      seq = Support::CommandSequence.new "exit"
      EasyRepl.stub :prompt, seq do
        out, err = capture_io do
          Support::SetupEasyRepl.start
        end
      end
      assert_equal "SETUP\n", out
    end

    it "calls setup when the reload command is entered" do
      out = ''
      seq = Support::CommandSequence.new "reload", "exit"
      EasyRepl.stub :prompt, seq do
        out, err = capture_io do
          Support::SetupEasyRepl.start
        end
      end
      assert_equal "SETUP\nSETUP\n", out
    end
  end
end
