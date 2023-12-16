# frozen_string_literal: true

require_relative '../../../lib/types/false'
require_relative '../../../lib/types/errors/rubyt_type_error'

describe False do
  let(:false_t) { described_class.new(false) }
  let(:false_t_false_t) { described_class.new(false_t) }

  describe '#initialize' do
    context 'when value is a false' do
      it 'instantiates' do
        expect { described_class.new(false) }.to_not raise_error
        expect(described_class.new(false)).to be_truthy
        expect(described_class.new(false)).to be_a described_class
      end
    end

    context 'when value is a False' do
      it 'instantiates' do
        expect { described_class.new(false_t) }.to_not raise_error
        expect(described_class.new(false_t)).to be_truthy
        expect(described_class.new(false_t)).to be_a described_class
      end
    end

    context 'when value is not a false' do
      it 'raises a RubytTypeError' do
        [
          [1, 'Expected FalseClass but got Integer instead'],
          [1.5, 'Expected FalseClass but got Float instead'],
          ['1', 'Expected FalseClass but got String instead'],
          [nil, 'Expected FalseClass but got NilClass instead'],
          [true, 'Expected FalseClass but got TrueClass instead'],
          [{}, 'Expected FalseClass but got Hash instead'],
          [[], 'Expected FalseClass but got Array instead']
        ].each do |value, error_message|
          expect { described_class.new(value) }.to raise_error RubytTypeError, error_message
        end
      end
    end
  end

  describe '#t=' do
    context 'when value is a false' do
      it 'sets the value' do
        false_t.t = described_class.new(false)
        false_t_false_t.t = false

        expect(false_t.t).to eq false
        expect(false_t_false_t.t).to eq false
      end
    end

    context 'when value is not a false' do
      it 'raises a RubytTypeError' do
        [
          [1, 'Expected FalseClass but got Integer instead'],
          [1.5, 'Expected FalseClass but got Float instead'],
          ['1', 'Expected FalseClass but got String instead'],
          [nil, 'Expected FalseClass but got NilClass instead'],
          [true, 'Expected FalseClass but got TrueClass instead'],
          [{}, 'Expected FalseClass but got Hash instead'],
          [[], 'Expected FalseClass but got Array instead']
        ].each do |value, error_message|
          expect { false_t.t = value }.to raise_error RubytTypeError, error_message
        end
      end
    end
  end

  describe '#self.t' do
    context 'when value is a False' do
      it 'returns value' do
        [false_t, false_t_false_t].each do |value|
          expect { described_class.t value }.to_not raise_error
          expect(described_class.t(value)).to eq value
        end
      end
    end

    context 'when value is not a False' do
      it 'raises a RubytTypeError' do
        [
          [1, 'Expected False but got Integer instead'],
          [1.5, 'Expected False but got Float instead'],
          ['1', 'Expected False but got String instead'],
          [nil, 'Expected False but got NilClass instead'],
          [true, 'Expected False but got TrueClass instead'],
          [false, 'Expected False but got FalseClass instead'],
          [{}, 'Expected False but got Hash instead'],
          [[], 'Expected False but got Array instead']
        ].each do |value, error_message|
          expect { described_class.t value }.to raise_error RubytTypeError, error_message
        end
      end
    end
  end
end
