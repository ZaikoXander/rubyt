# frozen_string_literal: true

require_relative '../../../lib/types/integer_t'
require_relative '../../../lib/types/errors/rubyt_type_error'

describe IntegerT do
  let(:integer_t) { described_class.new(1) }
  let(:integer_t_integer_t) { described_class.new(integer_t) }

  describe '#initialize' do
    context 'when value is an integer' do
      it 'instantiates' do
        expect { described_class.new(1) }.to_not raise_error
        expect(described_class.new(1)).to be_truthy
        expect(described_class.new(1)).to be_a described_class
      end
    end

    context 'when value is an IntegerT' do
      it 'instantiates' do
        expect { described_class.new(integer_t) }.to_not raise_error
        expect(described_class.new(integer_t)).to be_truthy
        expect(described_class.new(integer_t)).to be_a described_class
      end
    end

    context 'when value is not an integer' do
      it 'raises a RubytTypeError' do
        [
          [1.5, 'Expected Integer but got Float instead'],
          ['1', 'Expected Integer but got String instead'],
          [nil, 'Expected Integer but got NilClass instead'],
          [true, 'Expected Integer but got TrueClass instead'],
          [false, 'Expected Integer but got FalseClass instead'],
          [{}, 'Expected Integer but got Hash instead'],
          [[], 'Expected Integer but got Array instead']
        ].each do |value, error_message|
          expect { described_class.new(value) }.to raise_error RubytTypeError, error_message
        end
      end
    end
  end

  describe '#t=' do
    context 'when value is an integer' do
      it 'sets the value' do
        integer_t.t = described_class.new(2)
        integer_t_integer_t.t = 2

        expect(integer_t.t).to eq 2
        expect(integer_t_integer_t.t).to eq 2
      end
    end

    context 'when value is not an integer' do
      it 'raises a RubytTypeError' do
        [
          [1.5, 'Expected Integer but got Float instead'],
          ['1', 'Expected Integer but got String instead'],
          [nil, 'Expected Integer but got NilClass instead'],
          [true, 'Expected Integer but got TrueClass instead'],
          [false, 'Expected Integer but got FalseClass instead'],
          [{}, 'Expected Integer but got Hash instead'],
          [[], 'Expected Integer but got Array instead']
        ].each do |value, error_message|
          expect { integer_t.t = value }.to raise_error RubytTypeError, error_message
        end
      end
    end
  end

  describe '#self.t' do
    context 'when value is an IntegerT' do
      it 'returns value' do
        [integer_t, integer_t_integer_t].each do |value|
          expect { described_class.t value }.to_not raise_error
          expect(described_class.t(value)).to eq value
        end
      end
    end

    context 'when value is not an IntegerT' do
      it 'raises a RubytTypeError' do
        [
          [1, 'Expected IntegerT but got Integer instead'],
          [1.5, 'Expected IntegerT but got Float instead'],
          ['1', 'Expected IntegerT but got String instead'],
          [nil, 'Expected IntegerT but got NilClass instead'],
          [true, 'Expected IntegerT but got TrueClass instead'],
          [false, 'Expected IntegerT but got FalseClass instead'],
          [{}, 'Expected IntegerT but got Hash instead'],
          [[], 'Expected IntegerT but got Array instead']
        ].each do |value, error_message|
          expect { described_class.t value }.to raise_error RubytTypeError, error_message
        end
      end
    end
  end
end
