# frozen_string_literal: true

require_relative '../../../../lib/types/errors/rubyt_must_not_be_nil_error'

describe RubytMustNotBeNilError do
  describe '#initialize' do
    it 'is a RubytError' do
      rubyt_must_not_be_nil_error = RubytMustNotBeNilError.new
      expect(rubyt_must_not_be_nil_error).to be_a RubytMustNotBeNilError
      expect(rubyt_must_not_be_nil_error).to be_a RubytError
    end

    it 'shows a message' do
      rubyt_must_not_be_nil_error = RubytMustNotBeNilError.new
      expect(rubyt_must_not_be_nil_error.message).to eq 'must not be nil'
    end

    it 'shows a custom message' do
      rubyt_must_not_be_nil_error = RubytMustNotBeNilError.new('Custom message')
      expect(rubyt_must_not_be_nil_error.message).to eq 'Custom message'
    end
  end
end
