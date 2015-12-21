class Carat::Parser
token KEY STRING NUMBER TRUE FALSE NEWLINE
rule
  document
    : entities
    ;

  entities
    : entities NEWLINE entity
    | entity
    ;

  entity
    : object
    | named_object
    | pair
    ;

  object
    : KEY '{' entities '}'
    ;

  named_object
    : KEY STRING '{' entities '}'
    ;

  pair
    : KEY '=' value
    ;

  values
    : values ',' value
    | value
    ;

  value
    : STRING
    | NUMBER
    | TRUE
    | FALSE
    | array
    ;

  array
    : '[' values ']'
    ;


end

---- inner

  require 'carat/handler'

  attr_reader :handler

  def initialize(tokenizer, handler = Handler.new)
    @tokenizer = tokenizer
    @handler = handler
    super
  end

  def next_token
    @tokenizer.next_token
  end

  def parse
    do_parse
    handler
  end
