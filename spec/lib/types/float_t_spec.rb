# frozen_string_literal: true

require_relative '../../../lib/types/float_t'
require_relative '../../../lib/types/errors/rubyt_type_error'

describe FloatT do
  let(:float_t) { described_class.new(1.5) }
  let(:float_t_float_t) { described_class.new(float_t) }

  describe '#initialize' do
    context 'when value is an Float' do
      it 'instantiates' do
        expect { described_class.new(1.5) }.to_not raise_error
        expect(described_class.new(1.5)).to be_truthy
        expect(described_class.new(1.5)).to be_a described_class
      end
    end

    context 'when value is an FloatT' do
      it 'instantiates' do
        expect { described_class.new(float_t) }.to_not raise_error
        expect(described_class.new(float_t)).to be_truthy
        expect(described_class.new(float_t)).to be_a described_class
      end
    end

    context 'when value is not an Float' do
      it 'raises a RubytTypeError' do
        [
          [1, 'Expected Float but got Integer instead'],
          ['1', 'Expected Float but got String instead'],
          [nil, 'Expected Float but got NilClass instead'],
          [true, 'Expected Float but got TrueClass instead'],
          [false, 'Expected Float but got FalseClass instead'],
          [[], 'Expected Float but got Array instead'],
          [{}, 'Expected Float but got Hash instead']
        ].each do |value, error_message|
          expect { described_class.new(value) }.to raise_error RubytTypeError, error_message
        end
      end
    end
  end

  describe '#t=' do
    context 'when value is an Float' do
      it 'sets the value' do
        float_t.t = 2.5
        float_t_float_t.t = described_class.new(3.5)

        expect(float_t.t).to eq 2.5
        expect(float_t_float_t.t).to eq 3.5
      end
    end

    context 'when value is not an Float' do
      it 'raises a RubytTypeError' do
        [
          [1, 'Expected Float but got Integer instead'],
          ['1', 'Expected Float but got String instead'],
          [nil, 'Expected Float but got NilClass instead'],
          [true, 'Expected Float but got TrueClass instead'],
          [false, 'Expected Float but got FalseClass instead'],
          [[], 'Expected Float but got Array instead'],
          [{}, 'Expected Float but got Hash instead']
        ].each do |value, error_message|
          expect { float_t.t = value }.to raise_error RubytTypeError, error_message
        end
      end
    end
  end

  describe '#self.t' do
    context 'when value is an FloatT' do
      it 'returns value' do
        [float_t, float_t_float_t].each do |value|
          expect { described_class.t value }.to_not raise_error
          expect(described_class.t(value)).to eq value
        end
      end
    end

    context 'when value is not an FloatT' do
      it 'raises a RubytTypeError' do
        [
          [1, 'Expected FloatT but got Integer instead'],
          [1.5, 'Expected FloatT but got Float instead'],
          ['1', 'Expected FloatT but got String instead'],
          [nil, 'Expected FloatT but got NilClass instead'],
          [true, 'Expected FloatT but got TrueClass instead'],
          [false, 'Expected FloatT but got FalseClass instead'],
          [{}, 'Expected FloatT but got Hash instead'],
          [[], 'Expected FloatT but got Array instead']
        ].each do |value, error_message|
          expect { described_class.t value }.to raise_error RubytTypeError, error_message
        end
      end
    end
  end
end
