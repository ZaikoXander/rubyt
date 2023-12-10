# frozen_string_literal: true

require_relative '../../../../lib/types/errors/rubyt_type_error'

describe RubytTypeError do
  describe '#initialize' do
    it 'is a RubytError' do
      rubyt_type_error = RubytTypeError.new(Integer, String)
      expect(rubyt_type_error).to be_a RubytTypeError
      expect(rubyt_type_error).to be_a RubytError
    end

    it 'receives a message' do
      rubyt_type_error = RubytTypeError.new(Integer, String)
      expect(rubyt_type_error.message).to eq 'Expected Integer but got String'
    end
  end
end
