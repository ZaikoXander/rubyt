# frozen_string_literal: true

require_relative '../../../lib/types/nil'
require_relative '../../../lib/types/errors/rubyt_type_error'

describe Nil do
  let(:nil_t) { described_class.new(nil) }
  let(:nil_t_nil_t) { described_class.new(nil_t) }

  describe '#initialize' do
    context 'when value is nil' do
      it 'instantiates' do
        expect { described_class.new(nil) }.to_not raise_error
        expect(described_class.new(nil)).to be_truthy
        expect(described_class.new(nil)).to be_a described_class
      end
    end

    context 'when value is a Nil' do
      it 'instantiates' do
        expect { described_class.new(nil_t) }.to_not raise_error
        expect(described_class.new(nil_t)).to be_truthy
        expect(described_class.new(nil_t)).to be_a described_class
      end
    end

    context 'when value is not nil' do
      it 'raises a RubytTypeError' do
        [
          [1, 'Expected NilClass but got Integer instead'],
          [1.5, 'Expected NilClass but got Float instead'],
          ['1', 'Expected NilClass but got String instead'],
          [true, 'Expected NilClass but got TrueClass instead'],
          [false, 'Expected NilClass but got FalseClass instead'],
          [{}, 'Expected NilClass but got Hash instead'],
          [[], 'Expected NilClass but got Array instead']
        ].each do |value, error_message|
          expect { described_class.new(value) }.to raise_error RubytTypeError, error_message
        end
      end
    end
  end

  describe '#t=' do
    context 'when value is nil' do
      it 'sets the value' do
        nil_t.t = described_class.new(nil)
        nil_t_nil_t.t = nil

        expect(nil_t.t).to eq nil
        expect(nil_t_nil_t.t).to eq nil
      end
    end

    context 'when value is not nil' do
      it 'raises a RubytTypeError' do
        [
          [1, 'Expected NilClass but got Integer instead'],
          [1.5, 'Expected NilClass but got Float instead'],
          ['1', 'Expected NilClass but got String instead'],
          [true, 'Expected NilClass but got TrueClass instead'],
          [false, 'Expected NilClass but got FalseClass instead'],
          [{}, 'Expected NilClass but got Hash instead'],
          [[], 'Expected NilClass but got Array instead']
        ].each do |value, error_message|
          expect { nil_t.t = value }.to raise_error RubytTypeError, error_message
        end
      end
    end
  end

  describe '#self.t' do
    context 'when value is a Nil' do
      it 'returns value' do
        [nil_t, nil_t_nil_t].each do |value|
          expect { described_class.t value }.to_not raise_error
          expect(described_class.t(value)).to eq value
        end
      end
    end

    context 'when value is not a Nil' do
      it 'raises a RubytTypeError' do
        [
          [1, 'Expected Nil but got Integer instead'],
          [1.5, 'Expected Nil but got Float instead'],
          ['1', 'Expected Nil but got String instead'],
          [nil, 'Expected Nil but got NilClass instead'],
          [true, 'Expected Nil but got TrueClass instead'],
          [false, 'Expected Nil but got FalseClass instead'],
          [{}, 'Expected Nil but got Hash instead'],
          [[], 'Expected Nil but got Array instead']
        ].each do |value, error_message|
          expect { described_class.t value }.to raise_error RubytTypeError, error_message
        end
      end
    end
  end
end
