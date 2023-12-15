# frozen_string_literal: true

require_relative '../../../lib/types/any'
require_relative '../../../lib/types/errors/rubyt_type_error'

describe Any do
  let(:hash_any) { described_class.new({}) }
  let(:integer_any) { described_class.new(1) }
  let(:string_any) { described_class.new('') }
  let(:nil_any) { described_class.new(nil) }

  describe '#initialize' do
    context 'when value is Any' do
      it 'instantiates' do
        expect { described_class.new }.to_not raise_error
        expect(described_class.new).to be_truthy
        expect(described_class.new).to be_a described_class

        ['', nil, true, false, 1, 1.0, {}, [], hash_any].each do |value|
          expect { described_class.new value }.to_not raise_error
          expect(described_class.new(value)).to be_truthy
          expect(described_class.new(value)).to be_a described_class
        end
      end
    end
  end

  describe '#t' do
    it 'returns the value' do
      expect(hash_any.t).to eq({})
      expect(integer_any.t).to eq 1
      expect(string_any.t).to eq ''
      expect(nil_any.t).to be_nil
    end
  end

  describe '#t=' do
    it 'sets the value' do
      hash_any.t = 1
      integer_any.t = 'Hello World!'
      string_any.t = nil
      nil_any.t = {}

      expect(hash_any.t).to eq 1
      expect(integer_any.t).to eq 'Hello World!'
      expect(string_any.t).to be_nil
      expect(nil_any.t).to eq({})
    end
  end

  describe '#to_s' do
    it 'returns a string representation of the value' do
      expect(hash_any.to_s).to eq '{}'
      expect(integer_any.to_s).to eq '1'
      expect(string_any.to_s).to eq ''
      expect(nil_any.to_s).to eq ''
    end
  end

  describe '#self.t' do
    context 'when value is Any' do
      it 'returns value' do
        [
          described_class.new(''),
          described_class.new(nil),
          described_class.new(true),
          described_class.new(false),
          described_class.new(1),
          described_class.new(1.0),
          described_class.new({}),
          described_class.new([])
        ].each do |value|
          expect { described_class.t value }.to_not raise_error
          expect(described_class.t(value)).to eq value
        end
      end
    end

    context 'when value is not Any' do
      it 'raises a RubytTypeError' do
        [
          ['', 'Expected Any but got String instead'],
          [nil, 'Expected Any but got NilClass instead'],
          [true, 'Expected Any but got TrueClass instead'],
          [false, 'Expected Any but got FalseClass instead'],
          [1, 'Expected Any but got Integer instead'],
          [1.0, 'Expected Any but got Float instead'],
          [{}, 'Expected Any but got Hash instead'],
          [[], 'Expected Any but got Array instead']
        ].each do |value|
          expect { described_class.t value[0] }.to raise_error RubytTypeError, value[1]
        end
      end
    end
  end
end
