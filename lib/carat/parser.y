class Carat::Parser
token KEY STRING NUMBER TRUE FALSE NEWLINE
rule
  document
    : entities
    ;

  entities
    : entities entity NEWLINE
    | entity NEWLINE
    ;

  entity
    : object
    | named_object
    | pair
    ;

  object
    : start_object entities end_object
    ;

  named_object
    : start_named_object entities end_object
    ;

  pair
    : key '=' value { @handler.pair(val[0], val[2]) }
    ;

  key
    : KEY
    ;

  values_minus_array
    : values_minus_array ',' value_minus_array { result.push val[2] }
    | value_minus_array { result = val }
    ;

  string
    : STRING { @handler.name(val[0]) }
    ;

  value
    | literal
    | array
    ;

  value_minus_array
    | literal
    ;

  literal
    : STRING
    | NUMBER { n = val[0]; result = n.count('.') > 0 ? n.to_f : n.to_i }
    | TRUE   { result = true }
    | FALSE  { result = false }
    ;

  array
    : '[' values_minus_array ']' { result = val[1] }
    | '[' ']' { result = [] }
    ;

  start_object : key '{'              { @handler.start_object }
  start_named_object : key string '{' { @handler.start_object }
  end_object : '}'                    { @handler.end_object }
end

---- inner

  require_relative 'handler'

  attr_reader :handler

  def initialize(tokenizer, handler = Handler.new)
    @tokenizer = tokenizer
    @handler = handler
    super()
  end

  def next_token
    @tokenizer.next_token
  end

  def parse
    do_parse
    handler
  end
