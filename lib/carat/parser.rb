require 'strscan'
require 'pry'

module Carat

  class SyntaxError < StandardError; end

  class Parser
    WHITESPACE = /\s+/
    KEY = /\w+/
    EQ = /=/
    NEWLINE = /\n/
    
    # values
    INT = /\A\d+\Z/
    STRING = /.*/

    def parse_file(file_name)
      str = File.read(file_name)
      parse(str)
    end
    
    def parse(str)
      @ast = []
      @line = 0
      
      @scanner = StringScanner.new(str)

      until @scanner.eos?
        @line += 1
        parse_pair
      end

      @ast
    end

    def syntax_error
      p @ast
      SyntaxError.new("Syntax error on line #{@line} (pos. #{@scanner.pos})")
    end

    def parse_pair
      skip_whitespace
      @ast << eat_key
      skip_whitespace
      @ast << eat_eq
      skip_whitespace
      @ast << eat_value
      @ast << eat_newline
    end

    def eat(regex)
      token = @scanner.scan(regex)
      fail syntax_error unless token
      token
    end

    def skip_whitespace
      skip(WHITESPACE)
    end

    def eat_eq
      [:EQ, eat(EQ)]
    end

    def eat_newline
      [:NEWLINE, eat(NEWLINE)]
    end

    def eat_key
      [:KEY, eat(KEY)]
    end

    def eat_value
      val = @scanner.check_until(/\n/).chomp
      type = match_value(val)

      eat(type_to_regex(type))


      [type, val]
    end

    def match_value(value)
      case value
      when INT
        :INT
      else
        :STRING
      end
    end

    def type_to_regex(type)
      case type
      when :INT then INT
      when :STRING then STRING
      end
    end

    def skip(regex)
      @scanner.skip(regex)
    end
  end
end
