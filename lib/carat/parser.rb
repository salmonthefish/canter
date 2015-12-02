require 'strscan'

module Carat

  class SyntaxError < StandardError; end

  class Parser
    WHITESPACE = /\s+/
    KEY = /\w+/
    EQ = /=/
    VALUE = /.*/
    NEWLINE = /\n/

    def parse_file(file_name)
      str = File.read(file_name)
      parse(str)
    end
    
    def parse(str)
      @ast = {}
      @line = 0
      
      @scanner = StringScanner.new(str)

      until @scanner.eos?
        @line += 1
        parse_pair
      end

      @ast
    end

    def syntax_error
      SyntaxError.new("Syntax error on line #{@line} (pos. #{@scanner.pos})")
    end

    def parse_pair
      skip(WHITESPACE)
      key = match(KEY)
      skip(WHITESPACE)
      match(EQ)
      skip(WHITESPACE)
      val = match(VALUE)
      match(NEWLINE)

      @ast[key] = {:string => val}
    end

    def match(regex)
      match = @scanner.scan(regex)
      fail syntax_error unless match
      match
    end

    def skip(regex)
      @scanner.skip(regex)
    end
  end
end
