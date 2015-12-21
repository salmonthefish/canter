require 'strscan'

module Carat
  class Tokenizer
    WHITESPACE = /[ \t]+/
    NEWLINE = /\n/
    KEY = /\w+/
    STRING = /"(?:[^"\\]|\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4}))*"/
    NUMBER = /-?(?:0|[1-9]\d*)(?:\.\d+)?(?:[eE][+-]?\d+)?/
    TRUE = /true/
    FALSE = /false/

    def initialize(io)
      @ss = StringScanner.new(io.read)
    end

    def self.tokenize_file(file_name)
      f = File.open(file_name)

      t = new(f)
      tokens = []

      while tok = t.next_token
        tokens << tok
      end

      tokens
    end

    def next_token
      return if @ss.eos?

      case
      when text = @ss.scan(NUMBER)      then [:NUMBER, text]
      when text = @ss.scan(KEY)         then [:KEY, text]
      when text = @ss.scan(STRING)      then [:STRING, text[/"(.*)"/,1]]
      when text = @ss.scan(TRUE)        then [:TRUE, text]
      when text = @ss.scan(FALSE)       then [:FALSE, text]
      when text = @ss.scan(WHITESPACE)  then next_token
      when text = @ss.scan(NEWLINE)     then [:NEWLINE, text] 
      else
        x = @ss.getch
        [x, x]
      end
    end
  end
end
