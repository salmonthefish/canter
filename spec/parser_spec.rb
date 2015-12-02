require 'spec_helper'

describe Carat::Parser do
  subject { Carat::Parser.new }

  it 'parses simple.conf' do
    result = subject.parse_file('spec/examples/simple.conf')
    
    expect(result).to eq(
      [
        [:KEY, "a"],
        [:EQ, "="],
        [:STRING, "b"],
        [:NEWLINE, "\n"]
      ]
    )
  end

  it 'parses multiple.conf' do
    result = subject.parse_file('spec/examples/multiple.conf')

    expect(result).to eq(
      [
        [:KEY, "a"],
        [:EQ, "="],
        [:STRING, "hello"],
        [:NEWLINE, "\n"],
        [:KEY, "b"],
        [:EQ, "="],
        [:STRING, "goodbye"],
        [:NEWLINE, "\n"],
        [:KEY, "c"],
        [:EQ, "="],
        [:STRING, "hallo"],
        [:NEWLINE, "\n"],
      ]
    )
  end

  it 'parses special.conf' do
    result = subject.parse_file('spec/examples/special.conf')

    expect(result).to eq(
      [
        [:KEY, "hello"],
        [:EQ, "="],
        [:STRING, "*bob*@example.com"],
        [:NEWLINE, "\n"],
        [:KEY, "_weird_key"],
        [:EQ, "="],
        [:STRING, "//&*6*$#@!~`()?<>[]{}+=-|"],
        [:NEWLINE, "\n"]
      ]
    )
  end

  it 'parses simple_int.conf' do
    result = subject.parse_file('spec/examples/simple_int.conf')

    expect(result).to eq(
      [
        [:KEY, "a"],
        [:EQ, "="],
        [:INT, "1"],
        [:NEWLINE, "\n"]
      ]
    )
  end
end
