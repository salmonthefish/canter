require 'parslet'

class Carat < Parslet::Parser
  rule(:whitespace) { str(' ').repeat }
  rule(:whitespace?) { whitespace.maybe }
  rule(:eol) { match('\n') }
  rule(:lbrack) { str('[') >> whitespace? }
  rule(:rbrack) { str(']') >> whitespace? }
  rule(:comma) { str(',') >> whitespace? }
  rule(:eq) { whitespace >> str('=') >> whitespace }
  rule(:key) { match('\w').repeat.as(:key) }
  rule(:string) { match('\S').repeat.as(:string) }
  rule(:int) { match('\d').repeat.as(:int) }
  rule(:proper_float) { int >> str('.') >> int }
  rule(:pre_float) { str('.') >> int }
  rule(:post_float) { int >> str('.') }
  rule(:float) { (proper_float | pre_float | post_float).as(:float) }
  rule(:array) { (lbrack >> value_with_comma? >> value? >> rbrack).as(:array) }
  rule(:value) { (array | float | int | string) >> whitespace? }
  rule(:value?) { value.maybe }
  rule(:value_with_comma) { value >> comma }
  rule(:value_with_comma?) { value_with_comma.maybe }
  rule(:key_value_pair) { whitespace? >> key >> eq >> value >> eol }
  rule(:pairs) { key_value_pair.repeat }
  root :pairs
end

def parse_file(file_name)
  txt = File.read(file_name)
  puts Carat.new.parse(txt)
rescue Parslet::ParseFailed => failure
  puts failure.cause.ascii_tree
end

