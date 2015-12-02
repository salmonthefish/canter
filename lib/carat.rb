require 'carat/parser'

def parse_file(file_name)
  p Carat::Parser.new.parse_file(file_name)
end
