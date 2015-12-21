require 'spec_helper'

describe Carat do
  it 'parses simple.conf' do
    result = Carat.load_file('spec/examples/simple.conf')

    expect(result).to eq(
      [
        [:root,
         [:pair, "a", "b"]]
      ]
    )
  end

  it 'parses multiple.conf' do
    result = Carat.load_file('spec/examples/multiple.conf')

    expect(result).to eq(
      [
        [:root,
         [:pair, "a", "hello"],
         [:pair, "b", "goodbye"],
         [:pair, "c", "hallo"]]
      ]
    )
  end

  it 'parses array.conf' do
    result = Carat.load_file('spec/examples/array.conf')

    expect(result).to eq(
      [
        [:root,
         [:pair, "a", [1,2,3]]]
      ]
    )
  end

  it 'parses empty_array.conf' do
    result = Carat.load_file('spec/examples/empty_array.conf')

    expect(result).to eq(
      [
        [:root,
         [:pair, "a", []]]
      ]
    )
  end
end
