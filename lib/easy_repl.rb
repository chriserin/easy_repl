require './lib/easy_repl/repl'
require './lib/easy_repl/commands/matchable'
require './lib/easy_repl/commands/exit'
require './lib/easy_repl/commands/reload'
require "./lib/easy_repl/version"


module EasyRepl
  extend EasyRepl::Repl

  def self.setup; end
  def self.teardown; end
end
