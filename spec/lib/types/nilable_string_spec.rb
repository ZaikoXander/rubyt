# frozen_string_literal: true

require_relative '../../../lib/types/nilable_string'
require_relative '../../../lib/types/errors/rubyt_type_error'

describe NilableString do
  let(:no_args_nilable_string) { described_class.new }
  let(:string_nilable_string) { described_class.new 'Hello World!' }
  let(:nil_nilable_string) { described_class.new nil }
  let(:nilable_string_nilable_string) { described_class.new string_nilable_string }

  describe '#initialize' do
    context 'when value is a nilable string' do
      it 'instantiates' do
        expect { described_class.new }.to_not raise_error
        expect(described_class.new).to be_truthy
        expect(described_class.new).to be_a described_class

        ['Hello World!', nil, string_nilable_string].each do |value|
          expect { described_class.new value }.to_not raise_error
          expect(described_class.new(value)).to be_truthy
          expect(described_class.new(value)).to be_a described_class
        end
      end
    end

    context 'when value is not a nilable string' do
      it 'raises a RubytTypeError' do
        [
          [true, 'Expected NilClass or String but got TrueClass'],
          [false, 'Expected NilClass or String but got FalseClass'],
          [1, 'Expected NilClass or String but got Integer'],
          [1.0, 'Expected NilClass or String but got Float'],
          [{}, 'Expected NilClass or String but got Hash'],
          [[], 'Expected NilClass or String but got Array']
        ].each do |value|
          expect { described_class.new value }.to raise_error RubytTypeError
        end
      end
    end
  end

  describe '#t=' do
    context 'when value is a nilable string' do
      it 'sets the value' do
        no_args_nilable_string.t = 'Hello World!'
        string_nilable_string.t = nil
        nil_nilable_string.t = 'Hello World!'
        nilable_string_nilable_string.t = string_nilable_string

        expect(no_args_nilable_string.t).to eq 'Hello World!'
        expect(string_nilable_string.t).to be_nil
        expect(nil_nilable_string.t).to eq 'Hello World!'
        expect(nilable_string_nilable_string.t).to be_nil
      end
    end

    context 'when value is not a nilable string' do
      it 'raises a RubytTypeError' do
        [
          [true, 'Expected NilClass or String but got TrueClass'],
          [false, 'Expected NilClass or String but got FalseClass'],
          [1, 'Expected NilClass or String but got Integer'],
          [1.0, 'Expected NilClass or String but got Float'],
          [{}, 'Expected NilClass or String but got Hash'],
          [[], 'Expected NilClass or String but got Array']
        ].each do |value|
          expect { no_args_nilable_string.t = value[0] }.to raise_error RubytTypeError, value[1]
        end
      end
    end
  end

  describe '#self.t' do
    context 'when value is a nilable string' do
      it 'returns value' do
        [described_class.new('Hello World!'), described_class.new(nil), described_class.new].each do |value|
          expect { described_class.t value }.to_not raise_error
          expect(described_class.t(value)).to eq value
        end
      end
    end

    context 'when value is not a nilable string' do
      it 'raises a RubytTypeError' do
        [
          [true, 'Expected NilableString but got TrueClass'],
          [false, 'Expected NilableString but got FalseClass'],
          [1, 'Expected NilableString but got Integer'],
          [1.0, 'Expected NilableString but got Float'],
          [{}, 'Expected NilableString but got Hash'],
          [[], 'Expected NilableString but got Array'],
          ['', 'Expected NilableString but got String'],
          [nil, 'Expected NilableString but got NilClass']
        ].each do |value|
          expect { described_class.t value[0] }.to raise_error RubytTypeError, value[1]
        end
      end
    end
  end
end
