def parse_file(file_name)
  str = File.read(file_name)
  Carat::Parser.new.parse(str)
end
