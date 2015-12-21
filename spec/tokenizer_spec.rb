require 'spec_helper'

describe Carat::Tokenizer do
  subject { Carat::Tokenizer }

  it 'tokenizes simple.conf' do
    result = subject.tokenize_file('spec/examples/simple.conf')
    
    expect(result).to eq(
      [
        [:KEY, "a"],
        ["=", "="],
        [:STRING, "b"],
        [:NEWLINE, "\n"]
      ]
    )
  end

  it 'tokenizes multiple.conf' do
    result = subject.tokenize_file('spec/examples/multiple.conf')

    expect(result).to eq(
      [
        [:KEY, "a"],
        ["=", "="],
        [:STRING, "hello"],
        [:NEWLINE, "\n"],
        [:KEY, "b"],
        ["=", "="],
        [:STRING, "goodbye"],
        [:NEWLINE, "\n"],
        [:KEY, "c"],
        ["=", "="],
        [:STRING, "hallo"],
        [:NEWLINE, "\n"],
      ]
    )
  end

  it 'tokenizes special.conf' do
    result = subject.tokenize_file('spec/examples/special.conf')

    expect(result).to eq(
      [
        [:KEY, "hello"],
        ["=", "="],
        [:STRING, "*bob*@example.com"],
        [:NEWLINE, "\n"],
        [:KEY, "_weird_key"],
        ["=", "="],
        [:STRING, "//&*6*$#@!~`()?<>[]{}+=-|"],
        [:NEWLINE, "\n"]
      ]
    )
  end

  it 'tokenizes simple_int.conf' do
    result = subject.tokenize_file('spec/examples/simple_int.conf')

    expect(result).to eq(
      [
        [:KEY, "a"],
        ["=", "="],
        [:NUMBER, "1"],
        [:NEWLINE, "\n"]
      ]
    )
  end

  it 'tokenizes object.conf' do
    result = subject.tokenize_file('spec/examples/object.conf')

    expect(result).to eq(
      [
        [:KEY, "hello"],
        ["{", "{"],
        [:NEWLINE, "\n"],
        [:KEY, "a"],
        ["=", "="],
        [:STRING, "b"],
        [:NEWLINE, "\n"],
        ["}", "}"],
        [:NEWLINE, "\n"],
      ]
    )
  end

  it 'tokenizes variety.conf' do
    result = subject.tokenize_file('spec/examples/variety.conf')

    expect(result).to eq(
      [
        [:KEY, "a"], 
        ["=", "="], 
        [:NUMBER, "1"], 
        [:NEWLINE, "\n"], 
        [:KEY, "a_key"], 
        ["=", "="], 
        [:STRING, "a_value"], 
        [:NEWLINE, "\n"], 
        [:KEY, "a_number"], 
        ["=", "="], 
        [:NUMBER, "5"], 
        [:NEWLINE, "\n"], 
        [:KEY, "a_decimal"], 
        ["=", "="], 
        [:NUMBER, "3.14"], 
        [:NEWLINE, "\n"], 
        [:KEY, "another_decimal"], 
        ["=", "="], 
        [:NUMBER, "4.0"], 
        [:NEWLINE, "\n"], 
        [:KEY, "yet_another_decimal"], 
        ["=", "="], 
        [:NUMBER, "0.4"], 
        [:NEWLINE, "\n"], 
        [:KEY, "an_array"], 
        ["=", "="], 
        ["[", "["], 
        [:NUMBER, "1"], 
        [",", ","], 
        [:NUMBER, "2"], 
        [",", ","], 
        [:NUMBER, "3"], 
        ["]", "]"], 
        [:NEWLINE, "\n"], 
        [:KEY, "an_array_with_no_spaces"], 
        ["=", "="], 
        ["[", "["], 
        [:NUMBER, "1"], 
        [",", ","], 
        [:NUMBER, "2"], 
        [",", ","], 
        [:NUMBER, "3"], 
        ["]", "]"], 
        [:NEWLINE, "\n"], 
        [:KEY, "another_array"], 
        ["=", "="], 
        ["[", "["], 
        [:STRING, "one"], 
        [",", ","], 
        [:STRING, "two"], 
        [",", ","], 
        [:STRING, "three"], 
        ["]", "]"], 
        [:NEWLINE, "\n"], 
        [:KEY, "an_empty_array"], 
        ["=", "="], 
        ["[", "["], 
        ["]", "]"], 
        [:NEWLINE, "\n"]
      ]
    )
  end
end
