require 'carat/tokenizer'
require 'carat/parser'
require 'stringio'

module Carat
  def self.load(str)
    input = StringIO.new(str)
    parse_io(input)
  end

  def self.load_file(file_name)
    f = File.open(file_name)
    parse_io(f)
  end

  def self.parse_io(io)
    tokenizer = Carat::Tokenizer.new(io)
    parser = Carat::Parser.new(tokenizer)
    handler = parser.parse
    handler.result
  end
end
