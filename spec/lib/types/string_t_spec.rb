# frozen_string_literal: true

require_relative '../../../lib/types/string_t'
require_relative '../../../lib/types/errors/rubyt_type_error'

describe StringT do
  let(:string_t) { described_class.new('') }
  let(:string_t_string_t) { described_class.new(string_t) }

  describe '#initialize' do
    context 'when value is an string' do
      it 'instantiates' do
        expect { described_class.new('') }.to_not raise_error
        expect(described_class.new('')).to be_truthy
        expect(described_class.new('')).to be_a described_class
      end
    end

    context 'when value is an StringT object' do
      it 'instantiates' do
        expect { described_class.new(string_t) }.to_not raise_error
        expect(described_class.new(string_t)).to be_truthy
        expect(described_class.new(string_t)).to be_a described_class
      end
    end

    context 'when value is not an string' do
      it 'raises a RubytTypeError' do
        [
          [1, 'Expected String but got Integer'],
          [1.5, 'Expected String but got Float'],
          [nil, 'Expected String but got NilClass'],
          [true, 'Expected String but got TrueClass'],
          [false, 'Expected String but got FalseClass'],
          [{}, 'Expected String but got Hash'],
          [[], 'Expected String but got Array']
        ].each do |value|
          expect { described_class.new(value[0]) }.to raise_error RubytTypeError, value[1]
        end
      end
    end
  end

  describe '#t=' do
    context 'when value is an string' do
      it 'sets the value' do
        string_t.t = 'a'
        string_t_string_t.t = described_class.new('b')

        expect(string_t.t).to eq 'a'
        expect(string_t_string_t.t).to eq 'b'
      end
    end

    context 'when value is not an string' do
      it 'raises a RubytTypeError' do
        [
          [1, 'Expected String but got Integer'],
          [1.5, 'Expected String but got Float'],
          [nil, 'Expected String but got NilClass'],
          [true, 'Expected String but got TrueClass'],
          [false, 'Expected String but got FalseClass'],
          [{}, 'Expected String but got Hash'],
          [[], 'Expected String but got Array']
        ].each do |value|
          expect { string_t.t = value[0] }.to raise_error RubytTypeError, value[1]
        end
      end
    end
  end

  describe '#self.t' do
    context 'when value is an StringT' do
      it 'returns value' do
        [string_t, described_class.new(string_t)].each do |value|
          expect { described_class.t value }.to_not raise_error
          expect(described_class.t(value)).to eq value
        end
      end
    end

    context 'when value is not an StringT' do
      it 'raises a RubytRubytTypeError' do
        [
          ['', 'Expected StringT but got String'],
          [1, 'Expected StringT but got Integer'],
          [1.5, 'Expected StringT but got Float'],
          [nil, 'Expected StringT but got NilClass'],
          [true, 'Expected StringT but got TrueClass'],
          [false, 'Expected StringT but got FalseClass'],
          [{}, 'Expected StringT but got Hash'],
          [[], 'Expected StringT but got Array']
        ].each do |value|
          expect { described_class.t value[0] }.to raise_error RubytTypeError, value[1]
        end
      end
    end
  end
end
