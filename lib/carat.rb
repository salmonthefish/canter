require 'carat/tokenizer'

def parse_file(file_name)
  p Carat::Tokenizer.new(file_name)
end
