# frozen_string_literal: true

require_relative '../../../lib/types/hash_t'
require_relative '../../../lib/types/errors/rubyt_type_error'

describe HashT do
  let(:hash_t) { described_class.new({ h: 1 }) }
  let(:hash_t_hash_t) { described_class.new(hash_t) }

  describe '#initialize' do
    context 'when value is an Hash' do
      it 'instantiates' do
        expect { described_class.new({ h: 1 }) }.to_not raise_error
        expect(described_class.new({ h: 1 })).to be_truthy
        expect(described_class.new({ h: 1 })).to be_a described_class
      end
    end

    context 'when value is an HashT' do
      it 'instantiates' do
        expect { described_class.new(hash_t) }.to_not raise_error
        expect(described_class.new(hash_t)).to be_truthy
        expect(described_class.new(hash_t)).to be_a described_class
      end
    end

    context 'when value is not an Hash' do
      it 'raises a RubytTypeError' do
        [
          [1, 'Expected Hash but got Integer instead'],
          [1.5, 'Expected Hash but got Float instead'],
          ['1', 'Expected Hash but got String instead'],
          [nil, 'Expected Hash but got NilClass instead'],
          [true, 'Expected Hash but got TrueClass instead'],
          [false, 'Expected Hash but got FalseClass instead'],
          [[], 'Expected Hash but got Array instead']
        ].each do |value, error_message|
          expect { described_class.new(value) }.to raise_error RubytTypeError, error_message
        end
      end
    end
  end

  describe '#t=' do
    context 'when value is an Hash' do
      it 'sets the value' do
        hash_t.t = { c: 1 }
        hash_t_hash_t.t = described_class.new({ d: 2 })

        expect(hash_t.t).to eq({ c: 1 })
        expect(hash_t_hash_t.t).to eq({ d: 2 })
      end
    end

    context 'when value is not an Hash' do
      it 'raises a RubytTypeError' do
        [
          [1, 'Expected Hash but got Integer instead'],
          [1.5, 'Expected Hash but got Float instead'],
          ['1', 'Expected Hash but got String instead'],
          [nil, 'Expected Hash but got NilClass instead'],
          [true, 'Expected Hash but got TrueClass instead'],
          [false, 'Expected Hash but got FalseClass instead'],
          [[], 'Expected Hash but got Array instead']
        ].each do |value, error_message|
          expect { hash_t.t = value }.to raise_error RubytTypeError, error_message
        end
      end
    end
  end

  describe '#self.t' do
    context 'when value is an HashT' do
      it 'returns value' do
        [hash_t, hash_t_hash_t].each do |value|
          expect { described_class.t value }.to_not raise_error
          expect(described_class.t(value)).to eq value
        end
      end
    end

    context 'when value is not an HashT' do
      it 'raises a RubytTypeError' do
        [
          [1, 'Expected HashT but got Integer instead'],
          [1.5, 'Expected HashT but got Float instead'],
          ['1', 'Expected HashT but got String instead'],
          [nil, 'Expected HashT but got NilClass instead'],
          [true, 'Expected HashT but got TrueClass instead'],
          [false, 'Expected HashT but got FalseClass instead'],
          [{}, 'Expected HashT but got Hash instead'],
          [[], 'Expected HashT but got Array instead']
        ].each do |value, error_message|
          expect { described_class.t value }.to raise_error RubytTypeError, error_message
        end
      end
    end
  end
end
