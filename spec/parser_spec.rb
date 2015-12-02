require 'spec_helper'

describe Carat::Parser do
  subject { Carat::Parser.new }

  it 'parses simple.conf' do
    result = subject.parse_file('spec/examples/simple.conf')
    
    expect(result).to eq(
      {
        "a" => {:string => "b"}
      }
    )
  end

  it 'parses multiple.conf' do
    result = subject.parse_file('spec/examples/multiple.conf')

    expect(result).to eq(
      {
        "a" => {:string => "hello"},
        "b" => {:string => "goodbye"},
        "c" => {:string => "hallo"}
      }
    )
  end
end
