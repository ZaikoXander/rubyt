# frozen_string_literal: true

require_relative '../../../lib/types/nilable_string'
require_relative '../../../lib/types/errors/rubyt_type_error'

describe NilableString do
  let(:no_args_nilable_string) { described_class.new }
  let(:string_nilable_string) { described_class.new 'Hello World!' }
  let(:nil_nilable_string) { described_class.new nil }
  let(:nilable_string_nilable_string) { described_class.new string_nilable_string }

  describe '#initialize' do
    context 'when no value is given' do
      it 'instantiates' do
        expect { described_class.new }.to_not raise_error
        expect(described_class.new).to be_truthy
        expect(described_class.new).to be_a described_class
      end
    end

    context 'when value is a nilable string' do
      it 'instantiates' do
        ['Hello World!', nil].each do |value|
          expect { described_class.new value }.to_not raise_error
          expect(described_class.new(value)).to be_truthy
          expect(described_class.new(value)).to be_a described_class
        end
      end
    end

    context 'when value is a NilableString' do
      it 'instantiates' do
        [no_args_nilable_string, string_nilable_string, nil_nilable_string].each do |value|
          expect { described_class.new(value) }.to_not raise_error
          expect(described_class.new(value)).to be_truthy
          expect(described_class.new(value)).to be_a described_class
        end
      end
    end

    context 'when value is not a nilable string' do
      it 'raises a RubytTypeError' do
        [
          [true, 'Expected NilClass or String but got TrueClass instead'],
          [false, 'Expected NilClass or String but got FalseClass instead'],
          [1, 'Expected NilClass or String but got Integer instead'],
          [1.0, 'Expected NilClass or String but got Float instead'],
          [{}, 'Expected NilClass or String but got Hash instead'],
          [[], 'Expected NilClass or String but got Array instead']
        ].each do |value, error_message|
          expect { described_class.new value }.to raise_error RubytTypeError, error_message
        end
      end
    end
  end

  describe '#t=' do
    context 'when value is a nilable string' do
      it 'sets the value' do
        [no_args_nilable_string, nil_nilable_string].each { |value| value.t = 'Hello World!' }
        string_nilable_string.t = nil
        nilable_string_nilable_string.t = string_nilable_string

        expect([no_args_nilable_string.t, nil_nilable_string.t]).to all(eq('Hello World!'))
        expect([string_nilable_string.t, nilable_string_nilable_string.t]).to all(be_nil)
      end
    end

    context 'when value is not a nilable string' do
      it 'raises a RubytTypeError' do
        [
          [true, 'Expected NilClass or String but got TrueClass instead'],
          [false, 'Expected NilClass or String but got FalseClass instead'],
          [1, 'Expected NilClass or String but got Integer instead'],
          [1.0, 'Expected NilClass or String but got Float instead'],
          [{}, 'Expected NilClass or String but got Hash instead'],
          [[], 'Expected NilClass or String but got Array instead']
        ].each do |value, error_message|
          expect { no_args_nilable_string.t = value }.to raise_error RubytTypeError, error_message
        end
      end
    end
  end

  describe '#self.t' do
    context 'when value is a nilable string' do
      it 'returns value' do
        [string_nilable_string, nil_nilable_string, no_args_nilable_string].each do |value|
          expect { described_class.t value }.to_not raise_error
          expect(described_class.t(value)).to eq value
        end
      end
    end

    context 'when value is not a nilable string' do
      it 'raises a RubytTypeError' do
        [
          [true, 'Expected NilableString but got TrueClass instead'],
          [false, 'Expected NilableString but got FalseClass instead'],
          [1, 'Expected NilableString but got Integer instead'],
          [1.0, 'Expected NilableString but got Float instead'],
          [{}, 'Expected NilableString but got Hash instead'],
          [[], 'Expected NilableString but got Array instead'],
          ['', 'Expected NilableString but got String instead'],
          [nil, 'Expected NilableString but got NilClass instead']
        ].each do |value, error_message|
          expect { described_class.t value }.to raise_error RubytTypeError, error_message
        end
      end
    end
  end
end
