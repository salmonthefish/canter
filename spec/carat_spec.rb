require 'spec_helper'

describe Carat do
  it 'parses simple.conf' do
    result = Carat.load_file('spec/examples/simple.conf')

    expect(result).to eq(
      [
        [:root,
         [:pair, :a, "b"]]
      ]
    )
  end

  it 'parses multiple.conf' do
    result = Carat.load_file('spec/examples/multiple.conf')

    expect(result).to eq(
      [
        [:root,
         [:pair, :a, "hello"],
         [:pair, :b, "goodbye"],
         [:pair, :c, "hallo"]]
      ]
    )
  end

  it 'parses array.conf' do
    result = Carat.load_file('spec/examples/array.conf')

    expect(result).to eq(
      [
        [:root,
         [:pair, :a, [1,2,3]]]
      ]
    )
  end

  it 'parses empty_array.conf' do
    result = Carat.load_file('spec/examples/empty_array.conf')

    expect(result).to eq(
      [
        [:root,
         [:pair, :a, []]]
      ]
    )
  end

  it 'parses variety.conf' do
    result = Carat.load_file('spec/examples/variety.conf')

    expect(result).to eq(
      [
        [:root,
         [:pair, :a, 1],
         [:pair, :a_key, "a_value"],
         [:pair, :a_number, 5],
         [:pair, :a_decimal, 3.14],
         [:pair, :another_decimal, 4.0],
         [:pair, :yet_another_decimal, 0.4],
         [:pair, :an_array, [1,2,3]],
         [:pair, :an_array_with_no_spaces, [1,2,3]],
         [:pair, :another_array, ["one","two","three"]],
         [:pair, :an_empty_array, []]]
      ]
    )
  end

  it 'parses object.conf' do
    result = Carat.load_file('spec/examples/object.conf')

    expect(result).to eq(
      [
        [:root,
         [:hash,
          [:name, :hello],
          [:pair, :a, "b"]]]
      ]
    )
  end

  it 'parses group_object.conf' do
    result = Carat.load_file('spec/examples/group_object.conf')

    expect(result).to eq(
      [
        [:root,
         [:hash,
          [:group_name, :profile, :hello],
          [:pair, :a, "b"]]]
      ]
    )
  end
end
