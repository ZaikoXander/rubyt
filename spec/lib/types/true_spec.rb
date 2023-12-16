# frozen_string_literal: true

require_relative '../../../lib/types/true'
require_relative '../../../lib/types/errors/rubyt_type_error'

describe True do
  let(:true_t) { described_class.new(true) }
  let(:true_t_true_t) { described_class.new(true_t) }

  describe '#initialize' do
    context 'when value is a true' do
      it 'instantiates' do
        expect { described_class.new(true) }.to_not raise_error
        expect(described_class.new(true)).to be_truthy
        expect(described_class.new(true)).to be_a described_class
      end
    end

    context 'when value is a True' do
      it 'instantiates' do
        expect { described_class.new(true_t) }.to_not raise_error
        expect(described_class.new(true_t)).to be_truthy
        expect(described_class.new(true_t)).to be_a described_class
      end
    end

    context 'when value is not a true' do
      it 'raises a RubytTypeError' do
        [
          [1, 'Expected TrueClass but got Integer instead'],
          [1.5, 'Expected TrueClass but got Float instead'],
          ['1', 'Expected TrueClass but got String instead'],
          [nil, 'Expected TrueClass but got NilClass instead'],
          [false, 'Expected TrueClass but got FalseClass instead'],
          [{}, 'Expected TrueClass but got Hash instead'],
          [[], 'Expected TrueClass but got Array instead']
        ].each do |value, error_message|
          expect { described_class.new(value) }.to raise_error RubytTypeError, error_message
        end
      end
    end
  end

  describe '#t=' do
    context 'when value is a true' do
      it 'sets the value' do
        true_t.t = described_class.new(true)
        true_t_true_t.t = true

        expect(true_t.t).to eq true
        expect(true_t_true_t.t).to eq true
      end
    end

    context 'when value is not a true' do
      it 'raises a RubytTypeError' do
        [
          [1, 'Expected TrueClass but got Integer instead'],
          [1.5, 'Expected TrueClass but got Float instead'],
          ['1', 'Expected TrueClass but got String instead'],
          [nil, 'Expected TrueClass but got NilClass instead'],
          [false, 'Expected TrueClass but got FalseClass instead'],
          [{}, 'Expected TrueClass but got Hash instead'],
          [[], 'Expected TrueClass but got Array instead']
        ].each do |value, error_message|
          expect { true_t.t = value }.to raise_error RubytTypeError, error_message
        end
      end
    end
  end

  describe '#self.t' do
    context 'when value is a True' do
      it 'returns value' do
        [true_t, true_t_true_t].each do |value|
          expect { described_class.t value }.to_not raise_error
          expect(described_class.t(value)).to eq value
        end
      end
    end

    context 'when value is not a True' do
      it 'raises a RubytTypeError' do
        [
          [1, 'Expected True but got Integer instead'],
          [1.5, 'Expected True but got Float instead'],
          ['1', 'Expected True but got String instead'],
          [nil, 'Expected True but got NilClass instead'],
          [true, 'Expected True but got TrueClass instead'],
          [false, 'Expected True but got FalseClass instead'],
          [{}, 'Expected True but got Hash instead'],
          [[], 'Expected True but got Array instead']
        ].each do |value, error_message|
          expect { described_class.t value }.to raise_error RubytTypeError, error_message
        end
      end
    end
  end
end
