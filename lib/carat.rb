require 'parslet'

class Carat < Parslet::Parser
  rule(:whitespace) { match('[ \t\n]').repeat }
  rule(:eq) { str('=') >> whitespace.maybe }
  rule(:key) { match('\w').repeat.as(:key) >> whitespace.maybe }
  rule(:value) { match('[^\n]').repeat.as(:value) >> whitespace.maybe }
  rule(:key_value_pair) { whitespace.maybe >> key >> eq >> value }
  rule(:pairs) { key_value_pair.repeat }
  root :pairs
end

def parse_file(file_name)
  txt = File.read(file_name)
  puts Carat.new.parse(txt)
rescue Parslet::ParseFailed => failure
  puts failure.cause.ascii_tree
end

