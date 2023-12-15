# frozen_string_literal: true

require_relative '../../../lib/types/array_t'
require_relative '../../../lib/types/errors/rubyt_type_error'

describe ArrayT do
  let(:array_t) { described_class.new([1]) }
  let(:array_t_array_t) { described_class.new(array_t) }

  describe '#initialize' do
    context 'when value is an array' do
      it 'instantiates' do
        expect { described_class.new([1]) }.to_not raise_error
        expect(described_class.new([1])).to be_truthy
        expect(described_class.new([1])).to be_a described_class
      end
    end

    context 'when value is an ArrayT' do
      it 'instantiates' do
        expect { described_class.new(array_t) }.to_not raise_error
        expect(described_class.new(array_t)).to be_truthy
        expect(described_class.new(array_t)).to be_a described_class
      end
    end

    context 'when value is not an array' do
      it 'raises a RubytTypeError' do
        [
          [1, 'Expected Array but got Integer instead'],
          [1.5, 'Expected Array but got Float instead'],
          ['1', 'Expected Array but got String instead'],
          [nil, 'Expected Array but got NilClass instead'],
          [true, 'Expected Array but got TrueClass instead'],
          [false, 'Expected Array but got FalseClass instead'],
          [{}, 'Expected Array but got Hash instead']
        ].each do |value, error_message|
          expect { described_class.new(value) }.to raise_error RubytTypeError, error_message
        end
      end
    end
  end

  describe '#t=' do
    context 'when value is an array' do
      it 'sets the value' do
        array_t.t = [1]
        array_t_array_t.t = described_class.new([2])

        expect(array_t.t).to eq [1]
        expect(array_t_array_t.t).to eq [2]
      end
    end

    context 'when value is not an array' do
      it 'raises a RubytTypeError' do
        [
          [1, 'Expected Array but got Integer instead'],
          [1.5, 'Expected Array but got Float instead'],
          ['1', 'Expected Array but got String instead'],
          [nil, 'Expected Array but got NilClass instead'],
          [true, 'Expected Array but got TrueClass instead'],
          [false, 'Expected Array but got FalseClass instead'],
          [{}, 'Expected Array but got Hash instead']
        ].each do |value, error_message|
          expect { array_t.t = value }.to raise_error RubytTypeError, error_message
        end
      end
    end
  end

  describe '#self.t' do
    context 'when value is an ArrayT' do
      it 'returns value' do
        [array_t, array_t_array_t].each do |value|
          expect { described_class.t value }.to_not raise_error
          expect(described_class.t(value)).to eq value
        end
      end
    end

    context 'when value is not an ArrayT' do
      it 'raises a RubytTypeError' do
        [
          [1, 'Expected ArrayT but got Integer instead'],
          [1.5, 'Expected ArrayT but got Float instead'],
          ['1', 'Expected ArrayT but got String instead'],
          [nil, 'Expected ArrayT but got NilClass instead'],
          [true, 'Expected ArrayT but got TrueClass instead'],
          [false, 'Expected ArrayT but got FalseClass instead'],
          [{}, 'Expected ArrayT but got Hash instead'],
          [[], 'Expected ArrayT but got Array instead']
        ].each do |value, error_message|
          expect { described_class.t value }.to raise_error RubytTypeError, error_message
        end
      end
    end
  end
end
