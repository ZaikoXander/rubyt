# frozen_string_literal: true

require_relative '../../../lib/types/string_t'
require_relative '../../../lib/types/array_t'
require_relative '../../../lib/types/errors/rubyt_type_error'

describe StringT do
  let(:string_t) { described_class.new('') }
  let(:string_t_string_t) { described_class.new(string_t) }
  let(:invalid_values) { ['', 1, 1.5, nil, true, false, {}, []] }

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
        ].each do |value, error_message|
          expect { described_class.new(value) }.to raise_error RubytTypeError, error_message
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
        ].each do |value, error_message|
          expect { string_t.t = value }.to raise_error RubytTypeError, error_message
        end
      end
    end
  end

  describe '#==' do
    context 'when other is a StringT' do
      context 'when values are equal' do
        it 'returns true' do
          expect(string_t == described_class.new('')).to be true
        end
      end

      context 'when values are not equal' do
        it 'returns false' do
          expect(string_t == described_class.new('hello')).to be false
        end
      end
    end

    context 'when other is not a StringT' do
      it 'returns false' do
        invalid_values.each do |value|
          expect(string_t == value).to be false
        end
      end
    end
  end

  describe '#!=' do
    context 'when other is a StringT' do
      context 'when values are equal' do
        it 'returns false' do
          expect(string_t != described_class.new('')).to be false
        end
      end

      context 'when values are not equal' do
        it 'returns true' do
          expect(string_t != described_class.new('hello')).to be true
        end
      end
    end

    context 'when other is not a StringT' do
      it 'returns true' do
        invalid_values.each do |value|
          expect(string_t != value).to be true
        end
      end
    end
  end

  describe '#self.t' do
    let(:string_t_array) { [string_t, string_t_string_t] }
    let(:invalid_values) do
      [
        ['', 'Expected StringT but got String instead'],
        [1, 'Expected StringT but got Integer instead'],
        [1.5, 'Expected StringT but got Float instead'],
        [nil, 'Expected StringT but got NilClass instead'],
        [true, 'Expected StringT but got TrueClass instead'],
        [false, 'Expected StringT but got FalseClass instead'],
        [{}, 'Expected StringT but got Hash instead'],
        [[], 'Expected StringT but got Array instead']
      ]
    end

    context 'when one value is given' do
      context 'when value is an StringT' do
        it 'returns value' do
          string_t_array.each do |value|
            expect { described_class.t value }.to_not raise_error
            expect(described_class.t(value)).to eq value
          end
        end
      end

      context 'when value is not an StringT' do
        it 'raises a RubytTypeError' do
          invalid_values.each do |value, error_message|
            expect { described_class.t value }.to raise_error RubytTypeError, error_message
          end
        end
      end
    end

    context 'when multiple values are given' do
      context 'when all values are StringT' do
        let(:two_string_t) { [described_class.new(''), described_class.new('')] }
        let(:three_string_t) { [described_class.new(''), described_class.new(''), described_class.new('')] }

        it 'returns an ArrayT of values' do
          expect { described_class.t(*two_string_t) }.to_not raise_error
          expect(described_class.t(*two_string_t)).to eq ArrayT.new([described_class.new(''), described_class.new('')])

          expect { described_class.t(*three_string_t) }.to_not raise_error
          expect(described_class.t(*three_string_t))
            .to eq ArrayT.new([described_class.new(''), described_class.new(''), described_class.new('')])
        end
      end

      context 'when one or more values are not StringT' do
        let(:invalid_values_combinations) do
          invalid_values.flat_map do |value, error_message|
            [
              [[string_t, value], error_message],
              [[value, string_t], error_message],
              *invalid_values.map { |other_value, _| [[value, other_value], error_message] }
            ]
          end
        end

        it 'raises a RubytTypeError' do
          invalid_values_combinations.each do |values, error_message|
            expect { described_class.t(*values) }.to raise_error RubytTypeError, error_message
          end
        end
      end
    end
  end
end
