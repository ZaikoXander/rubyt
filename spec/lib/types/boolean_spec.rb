# frozen_string_literal: true

require_relative '../../../lib/types/boolean'
require_relative '../../../lib/types/errors/rubyt_type_error'

describe Boolean do
  let(:true_boolean) { described_class.new true }
  let(:false_boolean) { described_class.new false }
  let(:true_boolean_boolean) { described_class.new true_boolean }

  describe '#initialize' do
    context 'when value is a boolean' do
      it 'instantiates' do
        [true, false, true_boolean].each do |value|
          expect { described_class.new value }.to_not raise_error
          expect(described_class.new(value)).to be_truthy
          expect(described_class.new(value)).to be_a described_class
        end
      end
    end

    context 'when value is not a boolean' do
      it 'raises a RubytTypeError' do
        [
          ['Hello World!', 'Expected TrueClass or FalseClass but got String'],
          [1, 'Expected TrueClass or FalseClass but got Integer'],
          [1.0, 'Expected TrueClass or FalseClass but got Float'],
          [{}, 'Expected TrueClass or FalseClass but got Hash'],
          [[], 'Expected TrueClass or FalseClass but got Array'],
          [nil, 'Expected TrueClass or FalseClass but got NilClass']
        ].each do |value|
          expect { described_class.new value[0] }.to raise_error RubytTypeError, value[1]
        end
      end
    end
  end

  describe '#t=' do
    context 'when value is a boolean' do
      it 'sets the value' do
        true_boolean.t = false
        false_boolean.t = true
        true_boolean_boolean.t = true_boolean

        expect(true_boolean.t).to eq false
        expect(false_boolean.t).to eq true
        expect(true_boolean_boolean.t).to eq false
      end
    end

    context 'when value is not a boolean' do
      it 'raises a RubytTypeError' do
        [
          ['Hello World!', 'Expected TrueClass or FalseClass but got String'],
          [1, 'Expected TrueClass or FalseClass but got Integer'],
          [1.0, 'Expected TrueClass or FalseClass but got Float'],
          [{}, 'Expected TrueClass or FalseClass but got Hash'],
          [[], 'Expected TrueClass or FalseClass but got Array'],
          [nil, 'Expected TrueClass or FalseClass but got NilClass']
        ].each do |value|
          expect { true_boolean.t = value[0] }.to raise_error RubytTypeError, value[1]
        end
      end
    end
  end

  describe '#self.t' do
    context 'when value is a boolean' do
      it 'returns value' do
        [true_boolean, false_boolean, true_boolean_boolean].each do |value|
          expect { described_class.t value }.not_to raise_error
          expect(described_class.t(value)).to eq value
        end
      end
    end

    context 'when value is not a boolean' do
      it 'raises a RubytTypeError' do
        [
          ['Hello World!', 'Expected Boolean but got String'],
          [1, 'Expected Boolean but got Integer'],
          [1.0, 'Expected Boolean but got Float'],
          [{}, 'Expected Boolean but got Hash'],
          [[], 'Expected Boolean but got Array'],
          [nil, 'Expected Boolean but got NilClass'],
          [true, 'Expected Boolean but got TrueClass'],
          [false, 'Expected Boolean but got FalseClass']
        ].each do |value|
          expect { described_class.t value[0] }.to raise_error RubytTypeError, value[1]
        end
      end
    end
  end
end
