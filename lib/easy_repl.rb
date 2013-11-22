

module EasyRepl
  attr_accessor :history_file
  def self.history_file=(value)
    @history_file = value
  end

  def self.history_file
    @history_file
  end

  require 'easy_repl/repl'
  require 'easy_repl/commands/matchable'
  require 'easy_repl/commands/exit'
  require 'easy_repl/commands/reload'
  require "easy_repl/version"
  extend EasyRepl::Repl
end
