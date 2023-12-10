# frozen_string_literal: true

require_relative '../../../../lib/types/errors/rubyt_must_not_be_nil_error'

describe RubytMustNotBeNilError do
  describe '#initialize' do
    it 'instantiates' do
      rubyt_must_not_be_nil_error = RubytMustNotBeNilError.new
      expect(rubyt_must_not_be_nil_error).to be_a RubytMustNotBeNilError
      expect(rubyt_must_not_be_nil_error).to be_a RubytError
    end
  end

  describe 'raising' do
    it 'raises with a message' do
      expect { raise RubytMustNotBeNilError }.to raise_error RubytMustNotBeNilError, 'must not be nil'
    end

    it 'raises with a custom message' do
      expect { raise RubytMustNotBeNilError, 'Custom message' }.to raise_error RubytMustNotBeNilError, 'Custom message'
    end
  end
end
