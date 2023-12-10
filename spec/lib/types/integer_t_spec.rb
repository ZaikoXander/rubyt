# frozen_string_literal: true

require_relative '../../../lib/types/integer_t'

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

    context 'when value is an IntegerT object' do
      it 'instantiates' do
        integer_t = described_class.new(1)
        expect { described_class.new(integer_t) }.to_not raise_error
        expect(described_class.new(integer_t)).to be_truthy
        expect(described_class.new(integer_t)).to be_a described_class
      end
    end

    context 'when value is not an integer' do
      it 'raises a RubytTypeError' do
        [
          [1.5, 'Expected Integer but got Float'],
          ['1', 'Expected Integer but got String'],
          [nil, 'Expected Integer but got NilClass'],
          [true, 'Expected Integer but got TrueClass'],
          [false, 'Expected Integer but got FalseClass'],
          [{}, 'Expected Integer but got Hash'],
          [[], 'Expected Integer but got Array']
        ].each do |value|
          expect { described_class.new(value[0]) }.to raise_error RubytTypeError, value[1]
        end
      end
    end
  end

  describe '#t=' do
    context 'when value is an integer' do
      it 'sets the value' do
        integer_t.t = 1
        integer_t_integer_t.t = described_class.new(2)

        expect(integer_t.t).to eq 1
        expect(integer_t_integer_t.t).to eq 2
      end
    end

    context 'when value is not an integer' do
      it 'raises a RubytTypeError' do
        [
          [1.5, 'Expected Integer but got Float'],
          ['1', 'Expected Integer but got String'],
          [nil, 'Expected Integer but got NilClass'],
          [true, 'Expected Integer but got TrueClass'],
          [false, 'Expected Integer but got FalseClass'],
          [{}, 'Expected Integer but got Hash'],
          [[], 'Expected Integer but got Array']
        ].each do |value|
          expect { integer_t.t = value[0] }.to raise_error RubytTypeError, value[1]
        end
      end
    end
  end

  describe '#self.t' do
    context 'when value is an IntegerT' do
      it 'returns value' do
        [integer_t, described_class.new(integer_t)].each do |value|
          expect { described_class.t value }.to_not raise_error
          expect(described_class.t(value)).to eq value
        end
      end
    end

    context 'when value is not an IntegerT' do
      it 'raises a RubytTypeError' do
        [
          [1, 'Expected IntegerT but got Integer'],
          [1.5, 'Expected IntegerT but got Float'],
          ['1', 'Expected IntegerT but got String'],
          [nil, 'Expected IntegerT but got NilClass'],
          [true, 'Expected IntegerT but got TrueClass'],
          [false, 'Expected IntegerT but got FalseClass'],
          [{}, 'Expected IntegerT but got Hash'],
          [[], 'Expected IntegerT but got Array']
        ].each do |value|
          expect { described_class.t value[0] }.to raise_error RubytTypeError, value[1]
        end
      end
    end
  end
end
