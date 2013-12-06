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
      Support::SetupEasyRepl.stub :prompt, seq do
        out, err = capture_io do
          Support::SetupEasyRepl.start
        end
      end
      assert_equal "SETUP\n", out
    end

    it "calls setup when the reload command is entered" do
      out = ''
      seq = Support::CommandSequence.new "reload", "exit"
      Support::SetupEasyRepl.stub :prompt, seq do
        out, err = capture_io do
          Support::SetupEasyRepl.start
        end
      end
      assert_equal "SETUP\nSETUP\n", out
    end
  end

  describe "teardown is defined" do
    it "calls teardown before exiting" do
      out = ''
      seq = Support::CommandSequence.new "exit"
      Support::TeardownEasyRepl.stub :prompt, seq do
        out, err = capture_io do
          Support::TeardownEasyRepl.start
        end
      end
      assert_equal "TEARDOWN\n", out
    end

    it "calls teardown when the reload command is entered" do
      out = ''
      seq = Support::CommandSequence.new "reload", "exit"
      Support::TeardownEasyRepl.stub :prompt, seq do
        out, err = capture_io do
          Support::TeardownEasyRepl.start
        end
      end
      assert_equal "TEARDOWN\nTEARDOWN\n", out
    end
  end

  describe "before input is defined" do
    it "calls before input before every command" do
      out = ''
      seq = Support::CommandSequence.new "XXX", "exit"
      Support::BeforeInputEasyRepl.stub :prompt, seq do
        out, err = capture_io do
          Support::BeforeInputEasyRepl.start
        end
      end
      assert_equal "BEFOREINPUT\nXXX\nBEFOREINPUT\n", out
    end
  end

  describe "after input is defined" do
    it "calls after input after every command" do
      out = ''
      seq = Support::CommandSequence.new "XXX", "exit"
      Support::AfterInputEasyRepl.stub :prompt, seq do
        out, err = capture_io do
          Support::AfterInputEasyRepl.start
        end
      end
      assert_equal "XXX\nAFTERINPUT\nAFTERINPUT\n", out
    end
  end
end
