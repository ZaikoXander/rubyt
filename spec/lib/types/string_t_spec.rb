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

    context 'when value is an StringT' do
      it 'instantiates' do
        expect { described_class.new(string_t) }.to_not raise_error
        expect(described_class.new(string_t)).to be_truthy
        expect(described_class.new(string_t)).to be_a described_class
      end
    end

    context 'when value is not an string' do
      it 'raises a RubytTypeError' do
        [
          [1, 'Expected String but got Integer instead'],
          [1.5, 'Expected String but got Float instead'],
          [nil, 'Expected String but got NilClass instead'],
          [true, 'Expected String but got TrueClass instead'],
          [false, 'Expected String but got FalseClass instead'],
          [{}, 'Expected String but got Hash instead'],
          [[], 'Expected String but got Array instead']
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
          [1, 'Expected String but got Integer instead'],
          [1.5, 'Expected String but got Float instead'],
          [nil, 'Expected String but got NilClass instead'],
          [true, 'Expected String but got TrueClass instead'],
          [false, 'Expected String but got FalseClass instead'],
          [{}, 'Expected String but got Hash instead'],
          [[], 'Expected String but got Array instead']
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
      it 'raises a RubytTypeError' do
        [
          ['', 'Expected StringT but got String instead'],
          [1, 'Expected StringT but got Integer instead'],
          [1.5, 'Expected StringT but got Float instead'],
          [nil, 'Expected StringT but got NilClass instead'],
          [true, 'Expected StringT but got TrueClass instead'],
          [false, 'Expected StringT but got FalseClass instead'],
          [{}, 'Expected StringT but got Hash instead'],
          [[], 'Expected StringT but got Array instead']
        ].each do |value|
          expect { described_class.t value[0] }.to raise_error RubytTypeError, value[1]
        end
      end
    end
  end
end
