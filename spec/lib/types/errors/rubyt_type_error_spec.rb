# frozen_string_literal: true

require_relative '../../../../lib/types/errors/rubyt_type_error'

describe RubytTypeError do
  describe '#initialize' do
    it 'instantiates' do
      rubyt_type_error = RubytTypeError.new(Integer, String)
      expect(rubyt_type_error).to be_a RubytTypeError
      expect(rubyt_type_error).to be_a RubytError
    end
  end

  describe 'raising' do
    it 'raises with a message' do
      expect { raise RubytTypeError.new(Integer, String) }
        .to raise_error RubytTypeError, 'Expected Integer but got String instead'
    end
  end
end
